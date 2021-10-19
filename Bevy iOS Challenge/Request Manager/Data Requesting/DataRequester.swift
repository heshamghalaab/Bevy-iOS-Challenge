//
//  DataRequester.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 19/10/2021.
//

import Foundation
import os.log

struct DataRequester: DataRequesting {
    
    private let urlSession: URLSessionRequesting
    private let dataResponseHandler: DataResponseHandling
    private let urlRequestBuilder: URLRequestBuilding
    
    init(urlSession: URLSessionRequesting = URLSession.shared,
         dataResponseHandler: DataResponseHandling = DataResponseHandler(),
         urlRequestBuilder: URLRequestBuilding = URLRequestBuilder()) {
        
        self.urlSession = urlSession
        self.dataResponseHandler = dataResponseHandler
        self.urlRequestBuilder = urlRequestBuilder
    }
    
    func requestData<E>(
        from endPoint: E, completionHandler: @escaping (Result<Data?, NetworkError>) -> Void
    ) where E: EndPoint{
        
        os_log("requesting %@ feed %@ from %@ with override parameters: %@\nWith headers: %@",
               log: .requestsLogger, type: .debug, endPoint.httpMethod.rawValue, "\(E.self)", endPoint.fullPath, endPoint.parameters?.asDictionary ?? [:], endPoint.headers)
        
        guard let request = urlRequestBuilder.urlRequest(from: endPoint) else {
            return completionHandler(.failure(.urlGeneration))
        }

        let dataTask = self.urlSession.dataTask(with: request, completionHandler: { data, response, error in
            self.dataResponseHandler.handleRequestResponse(
                data, error: error, response: response,
                from: endPoint, completionHandler: completionHandler)
        })

        dataTask.resume()
    }
}
