//
//  EventViewModel.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 21/10/2021.
//

import Foundation

protocol EventViewModelOutputs {
    var eventName: String { get }
    var eventDescription: String { get }
    var eventDate: String { get }
    var eventImageURLValue: String { get }
}

protocol EventViewModelProtocol: AnyObject {
    var outputs: EventViewModelOutputs { get set }
}

class EventViewModel: EventViewModelOutputs, EventViewModelProtocol {
    
    var outputs: EventViewModelOutputs {
        get { self }
        set { }
    }
    
    private let event: Event
    
    init(event: Event){
        self.event = event
    }
        
    /// OutPuts
    var eventName: String { event.name }
    var eventDescription: String { event.description }
    var eventDate: String { event.startDate }
    var eventImageURLValue: String { event.cover }
}
