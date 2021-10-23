//
//  EventTypeViewModel.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 21/10/2021.
//

import Foundation

protocol EventTypeViewModelOutputs {
    var eventTypeText: String { get }
    var isSelected: Bool { get }
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
    
    init(eventType: EventType, isSelected: Bool){
        self.eventType = eventType
        self.isSelected = isSelected
    }
    
    /// OutPuts
    var eventTypeText: String { eventType.name }
    var isSelected: Bool
}
