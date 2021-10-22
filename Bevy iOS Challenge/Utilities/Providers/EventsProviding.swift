//
//  EventsProviding.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 19/10/2021.
//

import Foundation

protocol EventsProviding {
    func eventsTypes(completion: @escaping (Result<[EventType], Error>) -> Void)
    func events(eventType: String, page: Int, completion: @escaping (Result<[Event], Error>) -> Void)
}

struct EventsProvider: EventsProviding {

    private let requestManager: CanRequestFeeds

    init(requestManager: CanRequestFeeds = RequestManager()) {
        self.requestManager = requestManager
    }

    func eventsTypes(completion: @escaping (Result<[EventType], Error>) -> Void){
        let endPoint = RequestEndPoint<[EventType], EmptyParameters>(
            baseURL: .eventtusChanllenge, absolutePath: .eventtusChanllenge(.eventTypes),
            parameters: EmptyParameters(), httpMethod: .get, headers: [:])
        requestManager.request(from: endPoint) { result in
            switch result{
            case .success(let response): completion(.success(response))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
    
    func events(eventType: String, page: Int, completion: @escaping (Result<[Event], Error>) -> Void){
        let parameters = EventsParameters(eventType: eventType, page: page)
        let endPoint = RequestEndPoint<[Event], EventsParameters>(
            baseURL: .eventtusChanllenge, absolutePath: .eventtusChanllenge(.events),
            parameters: parameters, httpMethod: .get, headers: [:])
        requestManager.request(from: endPoint) { result in
            switch result{
            case .success(var response):
                self.makeEventsIdsUnique(eventType: eventType, page: page, response: &response)
                completion(.success(response))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
    
    private func makeEventsIdsUnique(eventType: String, page: Int, response: inout [Event]){
        for index in response.indices{
            response[index].makeEventIdUnique(withEventType: eventType, page: page)
        }
    }
}
