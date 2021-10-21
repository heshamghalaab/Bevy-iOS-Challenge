//
//  EventTypeViewModel.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 21/10/2021.
//

import Foundation

protocol EventTypeViewModelOutputs {
}

protocol EventTypeViewModelProtocol: AnyObject {
    var outputs: EventTypeViewModelOutputs { get set }
}

class EventTypeViewModel: EventTypeViewModelOutputs, EventTypeViewModelProtocol {
    
    var outputs: EventTypeViewModelOutputs {
        get { self }
        set { }
    }
    
    private let eventType: EventType
    
    init(eventType: EventType){
        self.eventType = eventType
    }
    
    /// OutPuts
}
