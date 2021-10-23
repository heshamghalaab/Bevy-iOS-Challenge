//
//  EventsProviderTests.swift
//  Bevy iOS ChallengeTests
//
//  Created by Ghalaab on 23/10/2021.
//

import XCTest
@testable import Bevy_iOS_Challenge

class EventsProviderTests: XCTestCase {

    func testProvider_whenSucceed() {
        var expectedData: Data!
        
        let eventTypes = [EventType(id: "0", name: "Test")]

        do {
            expectedData = try JSONEncoder().encode(eventTypes)
        } catch  {
            XCTFail("Failed to archived Data")
        }
        
        let mockedCache: EventsStorage = MockedEventsStorage(expectedEventTypes: eventTypes)
        let mockedRequestManager = MockedRequestManager(shouldError: false, expectedData: expectedData)
        let provider: EventsProviding = EventsProvider(requestManager: mockedRequestManager, cache: mockedCache)
        
        var fetchedEventTypes: [EventType] = []
        provider.eventsTypes(cached: { _ in }) {
            switch $0 {
            case .success(let types):
                fetchedEventTypes = types
            case .failure(_):
                XCTFail("Shouldn't have called")
            }
        }
        
        XCTAssertEqual(fetchedEventTypes, eventTypes)
    }
    
    func testProvider_whenFailed() {
        var expectedData: Data!
        do {
            expectedData = try JSONEncoder().encode(["id": 28])
        } catch  {
            XCTFail("Failed to archived Data")
        }
        
        let mockedRequestManager = MockedRequestManager(shouldError: true, error: .noResponse, expectedData: expectedData)
        let provider: EventsProviding = EventsProvider(requestManager: mockedRequestManager, cache: MockedEventsStorage())
        
        var fetchedError: Error!
        provider.eventsTypes(cached: { _ in }) {
            switch $0 {
            case .success(_):
                XCTFail("Shouldn't have called")
            case .failure(let error):
                fetchedError = error
            }
        }
        XCTAssertNotNil(fetchedError)
    }
}
