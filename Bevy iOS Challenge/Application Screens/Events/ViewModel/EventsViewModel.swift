//
//  EventsViewModel.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 21/10/2021.
//

import Foundation

protocol EventsViewModelInputs {
}

protocol EventsViewModelOutputs {
}

protocol EventsViewModelProtocol: AnyObject {
    var inputs: EventsViewModelInputs { get }
    var outputs: EventsViewModelOutputs { get set }
}

class EventsViewModel: EventsViewModelInputs, EventsViewModelOutputs, EventsViewModelProtocol {
    
    var inputs: EventsViewModelInputs { self }
    var outputs: EventsViewModelOutputs {
        get { self }
        set { }
    }
    
    private let provider: EventsProviding
    
    init(provider: EventsProviding = EventsProvider()){
        self.provider = provider
    }
    
    /// Inputs
    
    /// OutPuts

}
