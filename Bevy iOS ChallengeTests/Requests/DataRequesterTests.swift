//
//  DataRequesterTests.swift
//  Bevy iOS ChallengeTests
//
//  Created by Ghalaab on 23/10/2021.
//

import XCTest
@testable import Bevy_iOS_Challenge

class DataRequesterTests: XCTestCase {
   
    let absolutePath = BaseURL.eventtusChanllenge.value
    
    func testRequestingData_whenTheRequestIsSucceed() {
        var expectedData: Data!
        
        do {
            expectedData = try JSONEncoder().encode([EventType(id: "0", name: "Test")])
        } catch  {
            XCTFail("Failed to archived Data")
        }
        
        let urlSessionMock: URLSessionRequesting = URLSessionMock(expectedData: expectedData)
        let dataRequester: DataRequesting = DataRequester(urlSession: urlSessionMock)
        
        let endPoint = RequestEndPoint<[EventType], EmptyParameters>(
            baseURL: .eventtusChanllenge, absolutePath: .eventtusChanllenge(.eventTypes),
            parameters: EmptyParameters(), httpMethod: .get, headers: [:])
        
        var fetchedData: Data!
        dataRequester.requestData(from: endPoint) {
            switch $0 {
            case .success(let data):
                fetchedData = data
            case .failure(_):
                XCTFail("Shouldn't have called")
            }
        }
        
        XCTAssertEqual(fetchedData, expectedData)
    }
    
    func testRequestingData_whenTheRequestIsFailed() {

        let urlSessionMock: URLSessionRequesting = URLSessionMock(shouldError: true, withError: .urlGeneration)
        let dataRequester: DataRequesting = DataRequester(urlSession: urlSessionMock, dataResponseHandler: DataResponseHandlerMock())
        
        let endPoint = RequestEndPoint<[EventType], EmptyParameters>(
            baseURL: .eventtusChanllenge, absolutePath: .eventtusChanllenge(.eventTypes),
            parameters: EmptyParameters(), httpMethod: .get, headers: [:])

        var responseError: NetworkError!
        dataRequester.requestData(from: endPoint) {
            switch $0 {
            case .success(_):
                XCTFail("Shouldn't have called")
            case .failure(let error):
                responseError = error
            }
        }
        
        XCTAssertEqual(responseError, NetworkError.urlGeneration)
    }
}

fileprivate struct DataResponseHandlerMock: DataResponseHandling {
    func handleRequestResponse<E>(_ data: Data?, error: Error?, response: URLResponse?, from endPoint: E, completionHandler: @escaping (Result<Data?, NetworkError>) -> Void) where E : EndPoint {
        completionHandler(.failure(.urlGeneration))
    }
}

