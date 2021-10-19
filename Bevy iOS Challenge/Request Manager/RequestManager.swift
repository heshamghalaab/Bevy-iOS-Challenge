//
//  RequestManager.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 19/10/2021.
//

import Foundation
import os.log

protocol CanRequestFeeds {
    func request<E: EndPoint>(from endPoint: E, completionHandler: @escaping (Result<E.JSONResponseStructure, EndPointError>) -> Void)
}

struct RequestManager: CanRequestFeeds {
    
    private let dataRequester: DataRequesting
    private let responseDecoder: DataResponseDecoding

    init(dataRequester: DataRequesting = DataRequester(), responseDecoder: DataResponseDecoding = DataResponseDecoder()) {
        self.dataRequester = dataRequester
        self.responseDecoder = responseDecoder
    }
    
    func request<E: EndPoint>(from endPoint: E, completionHandler: @escaping (Result<E.JSONResponseStructure, EndPointError>) -> Void) {
        
        dataRequester.requestData(from: endPoint) { result in
            switch result {
            case .success(let data):
                
                do {
                    guard let data = data else {
                        return DispatchQueue.main.async { completionHandler(.failure(.noResponse)) }
                    }

                    let model: E.JSONResponseStructure = try self.responseDecoder.decodeModel(from: data)
                    DispatchQueue.main.async { completionHandler(.success(model)) }
                    
                } catch {
                    logDecodingError(error)
                    DispatchQueue.main.async { completionHandler(.failure(.parsing(error))) }
                }

            case .failure(let error):
                DispatchQueue.main.async { completionHandler(.failure(resolve(networkError: error))) }
            }
        }
    }
    
    private func resolve(networkError error: NetworkError) -> EndPointError {
        let resolvedError = error as Error
        return resolvedError is NetworkError ? .networkFailure(error) : .resolvedNetworkFailure(resolvedError)
    }
    
    private func logDecodingError(_ error: Error){
        switch error{
        case DecodingError.dataCorrupted(let context):
            os_log("############# DECODING_ERROR data Corrupted #############", log: .requestsLogger, type: .error)
            os_log("context '%@'", log: .requestsLogger, type: .error, context.debugDescription)
        case let DecodingError.keyNotFound(key, context):
            os_log("############# DECODING_ERROR Key Not found #############", log: .requestsLogger, type: .error)
            os_log("Key '%@' \ncontext: %@ \ncodingPath: %@", log: .requestsLogger, type: .error, "\(key)", context.debugDescription, context.codingPath)
        case let DecodingError.valueNotFound(value, context):
            os_log("############# DECODING_ERROR Value Not found #############", log: .requestsLogger, type: .error)
            os_log("Value '%@' \ncontext: %@ \ncodingPath: %@", log: .requestsLogger, type: .error, "\(value)", context.debugDescription, context.codingPath)
        case let DecodingError.typeMismatch(type, context):
            os_log("############# DECODING_ERROR Type mismatch #############", log: .requestsLogger, type: .error)
            os_log("Type '%@' \nmismatch: %@ \ncodingPath: %@", log: .requestsLogger, type: .error, "\(type)", context.debugDescription, context.codingPath)
        default:
            os_log("############# DECODING_ERROR Error #############", log: .requestsLogger, type: .error)
            os_log("UnExpected Error '%@'", log: .requestsLogger, type: .error, error.localizedDescription)
        }
    }
}


