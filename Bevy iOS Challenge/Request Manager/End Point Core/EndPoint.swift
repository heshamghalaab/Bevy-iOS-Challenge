//
//  EndPoint.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 19/10/2021.
//

import Foundation

protocol EndPoint {
    associatedtype JSONResponseStructure: Decodable
    associatedtype ParameterStructure: Encodable
    
    var baseURL: BaseURL { get }
    var absolutePath: AbsolutePath { get }
    var parameters: ParameterStructure? { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String: String] { get }
    var fullPath: String { get }
}

struct RequestEndPoint<Response: Decodable, Parameter: Encodable>: EndPoint {
    
    typealias JSONResponseStructure = Response
    typealias ParameterStructure = Parameter
    
    var baseURL: BaseURL
    var absolutePath: AbsolutePath
    var parameters: Parameter?
    var httpMethod: HTTPMethod
    var headers: [String: String]
    
    var fullPath: String{
        baseURL.value + absolutePath.value
    }
    
    init(baseURL: BaseURL,
         absolutePath: AbsolutePath,
         parameters: Parameter? = nil,
         httpMethod: HTTPMethod = .get,
         headers: [String: String] = [:]) {
        
        self.baseURL = baseURL
        self.absolutePath = absolutePath
        self.parameters = parameters
        self.httpMethod = httpMethod
        self.headers = headers
    }
}
