//
//  DataResponseHandler.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 19/10/2021.
//

import Foundation
import os.log

struct DataResponseHandler: DataResponseHandling {
    
    func handleRequestResponse<E>(
        _ data: Data? , error: Error?, response: URLResponse?,
        from endPoint: E, completionHandler: @escaping (Result<Data?, NetworkError>) -> Void
    ) where E: EndPoint{
        
        if let error = error{
            os_log("Error In Requesting %@ %@", log: .requestsLogger, type: .error, "\(E.self)", error.localizedDescription)
            let networkError = resolve(error: error)
            return completionHandler(.failure(networkError))
            
        }
        
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            os_log("Status code: %@", log: .requestsLogger, type: .error, "\(httpResponse.statusCode)")
            return completionHandler(.failure(.error(statusCode: httpResponse.statusCode, data: data)))
        }
        
        log(responseData: data)
        completionHandler(.success(data))
    }
    
    private func resolve(error: Error) -> NetworkError {
        let code = URLError.Code(rawValue: (error as NSError).code)
        switch code {
        case .notConnectedToInternet: return .notConnected
        default: return .generic(error)
        }
    }
    
    func log(responseData data: Data?) {
        guard let data = data else { return }
        let dataDict = try? JSONSerialization.jsonObject(with: data, options: [])
        os_log("Response: %@", log: .requestsLogger, type: .error, "\(String(describing: dataDict))")
    }
}
