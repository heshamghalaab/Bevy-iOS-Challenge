//
//  EventItem.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 23/10/2021.
//

import Foundation

class EventItem{
    let eventType: EventType
    var events: [Event]
    
    init(eventType: EventType, events: [Event]){
        self.eventType = eventType
        self.events = events
    }
}
