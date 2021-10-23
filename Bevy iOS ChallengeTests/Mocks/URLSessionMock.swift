//
//  URLSessionMock.swift
//  Bevy iOS ChallengeTests
//
//  Created by Ghalaab on 23/10/2021.
//

import Foundation
@testable import Bevy_iOS_Challenge

struct URLSessionMock: URLSessionRequesting {
    let shouldError: Bool
    let error: NetworkError
    let expectedData: Data
    let sessionDataTask = URLSession.shared.dataTask(with: URL(string: BaseURL.eventtusChanllenge.value)!)
    let response: HTTPURLResponse?

    init(shouldError: Bool = false, withError error: NetworkError = .urlGeneration,
         expectedData: Data = Data(), response: HTTPURLResponse? = HTTPURLResponse()) {
        self.shouldError = shouldError
        self.error = error
        self.expectedData = expectedData
        self.response = response
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        guard !shouldError else {
            completionHandler(nil, response, error)
            return sessionDataTask
        }
        
        completionHandler(expectedData, nil, nil)
        return sessionDataTask
    }
}

