//
//  MockedEventsStorage.swift
//  Bevy iOS ChallengeTests
//
//  Created by Ghalaab on 23/10/2021.
//

import Foundation
@testable import Bevy_iOS_Challenge

class MockedEventsStorage: EventsStorage {

    var expectedEventTypes: [EventType]
    var expectedEvents: [Event]
    
    init(expectedEventTypes: [EventType] = [], expectedEvents: [Event] = []) {
        self.expectedEventTypes = expectedEventTypes
        self.expectedEvents = expectedEvents
    }
    
    func getTypes(completion: @escaping (Result<[EventType]?, CoreDataStorageError>) -> Void) {
        completion(.success(expectedEventTypes))
    }
    
    func save(eventTypes: [EventType]) { }
    
    func getEvents(forEventType eventType: EventType, completion: @escaping (Result<[Event]?, CoreDataStorageError>) -> Void) {
        completion(.success(expectedEvents))
    }
    
    func save(events: [Event], forEventType eventType: EventType) { }
}
