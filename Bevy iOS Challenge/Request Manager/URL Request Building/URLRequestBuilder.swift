//
//  URLRequestBuilder.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 19/10/2021.
//

import Foundation
import os.log

struct URLRequestBuilder: URLRequestBuilding {
    
    func urlRequest<E>(from endPoint: E) -> URLRequest? where E : EndPoint{
        
        guard endPoint.fullPath.isValidUrl else { return nil }
        var urlComponents = URLComponents(string: endPoint.fullPath)

        if [.get, .head, .delete].contains(endPoint.httpMethod){
            let parameters = endPoint.parameters?.asDictionary?.map({ URLQueryItem(name: $0.key, value: "\($0.value)" )})
            urlComponents?.queryItems = parameters
        }

        guard let url = urlComponents?.url else {
            os_log("malformed url from path %@", log: .requestsLogger, type: .error, endPoint.fullPath)
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.httpMethod.rawValue
        for header in endPoint.headers{
            request.setValue(header.value, forHTTPHeaderField: header.key)
        }
        
        if ![.get, .head, .delete].contains(endPoint.httpMethod){
            
            do{
                // Convert model to JSON data
                let jsonObject = endPoint.parameters?.asDictionary ?? [:]
                let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                request.httpBody = jsonData
                return request
                
            }catch{
                
                os_log("Trying to convert model to JSON data %@", log: .requestsLogger, type: .error, error.localizedDescription)
                return nil
            }
        }else{
            return request
        }
    }

}
