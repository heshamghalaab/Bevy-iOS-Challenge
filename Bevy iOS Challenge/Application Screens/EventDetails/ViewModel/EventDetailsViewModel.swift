//
//  EventDetailsViewModel.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 22/10/2021.
//

import Foundation

protocol EventDetailsViewModelOutputs: EventViewModelOutputs {
    var latitude: Double { get }
    var longitude: Double { get }
}

protocol EventDetailsViewModelProtocol: AnyObject {
    var outputs: EventDetailsViewModelOutputs { get set }
}

class EventDetailsViewModel: EventDetailsViewModelOutputs, EventDetailsViewModelProtocol {
    
    var outputs: EventDetailsViewModelOutputs {
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
    var eventImageURL: URL? { URL(string: event.cover) }
    var latitude: Double { Double(event.latitude) ?? 0 }
    var longitude: Double { Double(event.longitude) ?? 0 }
}
