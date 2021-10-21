//
//  EventsViewModel.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 21/10/2021.
//

import Foundation

protocol EventsViewModelInputs {
    func getEventsTypes()
    
    func eventTypeViewModel(atRow row: Int) -> EventTypeViewModelProtocol
    func selectEventType(atRow row: Int)
    func isTheSelectEventType(atRow row: Int) -> Bool
}

protocol EventsViewModelOutputs {
    var showLoading: ( (EventsViewModelLoading?) -> Void )? { get set }
    var failureAlert: ( (_ message: String) -> Void )? { get set }
    var reloadEventsTypesData: ( () -> Void )? { get set }
    var numberOfEventsTypes: Int { get }
    var selectedEventType: EventType? { get }
}

enum EventsViewModelLoading {
    case fullScreen
    case nextPage
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
    private var eventsTypes: [EventType] = []
    
    
    init(provider: EventsProviding = EventsProvider()){
        self.provider = provider
    }
    
    /// Inputs
    func getEventsTypes(){
        showLoading?(.fullScreen)
        provider.eventsTypes { [weak self] result in
            guard let self = self else { return }
            switch result{
            case .failure(let error):
                let message = error.isInternetConnectionError ?
                "No internet connection": "Failed loading Events"
                self.failureAlert?(message)
            case .success(let response):
                self.eventsTypes = response
                self.selectedEventType = response.first
                self.reloadEventsTypesData?()
            }
            
            self.showLoading?(.none)
        }
    }
    
    func eventTypeViewModel(atRow row: Int) -> EventTypeViewModelProtocol{
        EventTypeViewModel(eventType: self.eventsTypes[row])
    }
    
    func selectEventType(atRow row: Int) {
        self.selectedEventType = eventsTypes[row]
        self.reloadEventsTypesData?()
        // ToDo: Get the events of this type.
    }
    
    func isTheSelectEventType(atRow row: Int) -> Bool {
        eventsTypes[row].id == selectedEventType?.id
    }
    
    /// OutPuts
    var showLoading: ( (EventsViewModelLoading?) -> Void )?
    var failureAlert: ( (_ message: String) -> Void )?
    var reloadEventsTypesData: ( () -> Void )?
    var numberOfEventsTypes: Int { eventsTypes.count }
    
    var selectedEventType: EventType? = nil
}
