//
//  MockedRequestManager.swift
//  Bevy iOS ChallengeTests
//
//  Created by Ghalaab on 23/10/2021.
//

import Foundation
@testable import Bevy_iOS_Challenge

class MockedRequestManager: CanRequestFeeds {
    
    let shouldError: Bool
    let error: EndPointError
    let expectedData: Data
    let responseDecoder: DataResponseDecoding
    
    init(shouldError: Bool, error: EndPointError = .noResponse, expectedData: Data,
         responseDecoder: DataResponseDecoding = DataResponseDecoder()) {
        self.shouldError = shouldError
        self.error = error
        self.expectedData = expectedData
        self.responseDecoder = responseDecoder
    }
    
    func request<E>(from endPoint: E, completionHandler: @escaping (Result<E.JSONResponseStructure, EndPointError>) -> Void) where E : EndPoint {
        if shouldError{
            completionHandler(.failure(error))
            return
        }
        
        do {
            let model: E.JSONResponseStructure = try self.responseDecoder.decodeModel(from: expectedData)
            completionHandler(.success(model))
        } catch {
            completionHandler(.failure(.parsing(error)))
        }
    }
}
 

