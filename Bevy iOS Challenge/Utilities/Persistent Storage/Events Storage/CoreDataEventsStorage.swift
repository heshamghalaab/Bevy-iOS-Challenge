//
//  CoreDataEventsStorage.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 22/10/2021.
//

import Foundation
import CoreData

class CoreDataEventsStorage: EventsStorage {

    private let coreDataStorage: CoreDataStorage

    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }
}

/// MARK: Event Types Operations
extension CoreDataEventsStorage {
    
    func getTypes(completion: @escaping (Result<[EventType]?, CoreDataStorageError>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let fetchRequest = EventTypeEntity.fetchRequest()
                let requestEntities = try context.fetch(fetchRequest)
                let values = requestEntities.map { $0.toEventType() }
                completion(.success(values))
            } catch {
                completion(.failure(CoreDataStorageError.readError(error)))
            }
        }
    }
    
    func save(eventTypes: [EventType]) {
        coreDataStorage.performBackgroundTask { context in
            eventTypes.forEach { eventType in
                let entity = eventType.toEntity(in: context)
                context.insert(entity)
            }
            do {
                try context.save()
            } catch {
                debugPrint("CoreDataMoviesResponseStorage Unresolved error \(error), \((error as NSError).userInfo)")
            }
        }
    }
}

/// MARK: Events Operations
extension CoreDataEventsStorage {
    func getEvents(forEventType eventType: EventType, completion: @escaping (Result<[Event]?, CoreDataStorageError>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let fetchRequest = EventIntity.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "eventTypeId == %@", eventType.id)
                
                let requestEntities = try context.fetch(fetchRequest)
                let values = requestEntities.map { $0.toEvent() }
                
                completion(.success(values))
            } catch {
                completion(.failure(CoreDataStorageError.readError(error)))
            }
        }
    }
    
    func save(events: [Event], forEventType eventType: EventType) {
        coreDataStorage.performBackgroundTask { context in
            events.forEach { event in
                let entity = event.toEntity(in: context, with: eventType)
                context.insert(entity)
            }

            do {
                try context.save()
            } catch {
                debugPrint("CoreDataMoviesResponseStorage Unresolved error \(error), \((error as NSError).userInfo)")
            }
        }
    }
}
