//
//  Entity+Mapping.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 23/10/2021.
//

import Foundation
import CoreData

extension EventType{
    func toEntity(in context: NSManagedObjectContext) -> EventTypeEntity {
        let entity: EventTypeEntity = EventTypeEntity(context: context)
        entity.id = self.id
        entity.name = self.name
        return entity
    }
}

extension EventTypeEntity{
    func toEventType() -> EventType {
        EventType(id: self.id ?? "", name: self.name ?? "")
    }
}

extension Event{
    func toEntity(in context: NSManagedObjectContext, with eventType: EventType) -> EventIntity {
        let entity: EventIntity = EventIntity(context: context)
        entity.cover = self.cover
        entity.endDate = self.endDate
        entity.eventDescription = self.description
        entity.id = self.id
        entity.latitude = self.latitude
        entity.longitude = self.longitude
        entity.name = self.name
        entity.startDate = self.startDate
        entity.eventTypeId = eventType.id
        return entity
    }
}

extension EventIntity{
    func toEvent() -> Event {
        Event(id: self.id ?? "", name: self.name ?? "", description: self.eventDescription ?? "",
              cover: self.cover ?? "", startDate: self.startDate ?? "", endDate: self.endDate ?? "",
              latitude: self.latitude ?? "", longitude: self.longitude ?? "")
    }
}
