//
//  EventsViewModelMock.swift
//  Bevy iOS ChallengeTests
//
//  Created by Ghalaab on 23/10/2021.
//

import Foundation
@testable import Bevy_iOS_Challenge

class MockedEventsProvider: EventsProviding{
    
    let eventTypeResult: Result<[EventType], Error>
    let cachedEventTypes: [EventType]
    
    let eventsResult: Result<[Event], Error>
    let cachedEvents: [Event]
    
    init(eventTypeResult: Result<[EventType], Error>,
         cachedEventTypes: [EventType],
         eventsResult: Result<[Event], Error>,
         cachedEvents: [Event]){
        self.eventTypeResult = eventTypeResult
        self.cachedEventTypes = cachedEventTypes
        self.eventsResult = eventsResult
        self.cachedEvents = cachedEvents
    }
    
    func eventsTypes(cached: @escaping ([EventType]) -> Void, completion: @escaping (Result<[EventType], Error>) -> Void) {
        cached(cachedEventTypes)
        completion(eventTypeResult)
    }
    
    func events(eventType: EventType, page: Int, cached: @escaping ([Event]) -> Void, completion: @escaping (Result<[Event], Error>) -> Void) {
        cached(cachedEvents)
        completion(eventsResult)
    }
}
