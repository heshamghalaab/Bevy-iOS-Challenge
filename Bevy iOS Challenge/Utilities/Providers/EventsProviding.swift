//
//  EventsProviding.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 19/10/2021.
//

import Foundation

protocol EventsProviding {
    func eventsTypes(cached: @escaping ([EventType]) -> Void,
                     completion: @escaping (Result<[EventType], Error>) -> Void)
    func events(eventType: EventType, page: Int,
                cached: @escaping ([Event]) -> Void,
                completion: @escaping (Result<[Event], Error>) -> Void)
}

struct EventsProvider: EventsProviding {

    private let requestManager: CanRequestFeeds
    private let cache: EventsStorage
    
    init(requestManager: CanRequestFeeds = RequestManager(),
         cache: EventsStorage = CoreDataEventsStorage()) {
        self.requestManager = requestManager
        self.cache = cache
    }

    func eventsTypes(cached: @escaping ([EventType]) -> Void,
                     completion: @escaping (Result<[EventType], Error>) -> Void){
        
        cache.getTypes { result in
            if case let .success(types) = result {
                DispatchQueue.main.async { cached(types ?? []) }
            }
            
            let endPoint = RequestEndPoint<[EventType], EmptyParameters>(
                baseURL: .eventtusChanllenge, absolutePath: .eventtusChanllenge(.eventTypes),
                parameters: EmptyParameters(), httpMethod: .get, headers: [:])
            requestManager.request(from: endPoint) { result in
                switch result{
                case .success(let response):
                    completion(.success(response))
                    self.cache.save(eventTypes: response)
                    
                case .failure(let error): completion(.failure(error))
                }
            }
        }
    }
    
    func events(eventType: EventType, page: Int,
                cached: @escaping ([Event]) -> Void,
                completion: @escaping (Result<[Event], Error>) -> Void){
        cache.getEvents(forEventType: eventType) { result in
            
            if case let .success(events) = result {
                DispatchQueue.main.async { cached(events ?? []) }
            }
            
            let parameters = EventsParameters(eventType: eventType.id, page: page)
            let endPoint = RequestEndPoint<[Event], EventsParameters>(
                baseURL: .eventtusChanllenge, absolutePath: .eventtusChanllenge(.events),
                parameters: parameters, httpMethod: .get, headers: [:])
            requestManager.request(from: endPoint) { result in
                switch result{
                case .success(var response):
                    self.makeEventsIdsUnique(eventType: eventType.name, page: page, response: &response)
                    
                    // will save only if it is the first page.
                    if page == 1{ self.cache.save(events: response, forEventType: eventType) }
                    
                    completion(.success(response))
                case .failure(let error): completion(.failure(error))
                }
            }
            
        }
    }
    
    private func makeEventsIdsUnique(eventType: String, page: Int, response: inout [Event]){
        for index in response.indices{
            response[index].makeEventIdUnique(withEventType: eventType, page: page)
        }
    }
}
