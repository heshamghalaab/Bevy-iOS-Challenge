//
//  EventsStorage.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 22/10/2021.
//

import Foundation

protocol EventsStorage {
    func save(eventTypes: [EventType])
    func getTypes(completion: @escaping (Result<[EventType]?, CoreDataStorageError>) -> Void)
    
    func save(events: [Event], forEventType eventType: EventType)
    func getEvents(
        forEventType eventType: EventType,
        completion: @escaping (Result<[Event]?, CoreDataStorageError>) -> Void)
}
