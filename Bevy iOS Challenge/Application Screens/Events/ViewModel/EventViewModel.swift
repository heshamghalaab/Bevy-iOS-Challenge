//
//  EventViewModel.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 21/10/2021.
//

import Foundation

protocol EventViewModelOutputs {
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

}
