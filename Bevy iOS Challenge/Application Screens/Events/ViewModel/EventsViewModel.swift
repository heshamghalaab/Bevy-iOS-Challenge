//
//  EventsViewModel.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 21/10/2021.
//

import Foundation

protocol EventsViewModelInputs {
    func getEventsTypes()
    func getEvents(fetchingType: EventsFetchingType)
    
    func eventTypeViewModel(atRow row: Int) -> EventTypeViewModelProtocol
    func selectEventType(atRow row: Int)
    func isTheSelectEventType(atRow row: Int) -> Bool
    
    func eventViewModel(atRow row: Int) -> EventViewModelProtocol
    func selectEvent(atRow row: Int)
    
    func nextEventsIfNeeded(at row: Int)
}

protocol EventsViewModelOutputs {
    var showLoading: ( (EventsFetchingType?) -> Void )? { get set }
    var failureAlert: ( (_ message: String) -> Void )? { get set }
    
    var reloadEventsTypesData: ( () -> Void )? { get set }
    var numberOfEventsTypes: Int { get }
    
    var reloadEventsData: ( () -> Void )? { get set }
    var numberOfEvents: Int { get }
    
    var selectedEventType: EventType? { get }
}

enum EventsFetchingType {
    case intialize
    case refresh
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
    private var events: [Event] = []
    private var currentPage: Int = 1
    private let MAXIMUM_PAGES = 3
    private var isGettingEvents: Bool = false
    
    init(provider: EventsProviding = EventsProvider()){
        self.provider = provider
    }
    
    /// Inputs
    func getEventsTypes(){
        showLoading?(.intialize)
        provider.eventsTypes { [weak self] result in
            guard let self = self else { return }
            self.showLoading?(.none)
            
            switch result{
            case .failure(let error):
                let message = error.isInternetConnectionError ?
                "No internet connection": "Failed loading Events"
                self.failureAlert?(message)
                
            case .success(let response):
                self.eventsTypes = response
                self.selectedEventType = response.first
                self.reloadEventsTypesData?()
                self.getEvents(fetchingType: .intialize)
            }
        }
    }
    
    func getEvents(fetchingType: EventsFetchingType){
        guard let eventTypeId = selectedEventType?.id else { return }
        guard !isGettingEvents else { return }
        
        self.showLoading?(fetchingType)
        self.isGettingEvents = true
        let page = getPage(for: fetchingType)
        
        provider.events(eventType: eventTypeId, page: page) { [weak self] result in
            guard let self = self else { return }
            switch result{
            case .failure(let error):
                let message = error.isInternetConnectionError ?
                "No internet connection": "Failed loading Events"
                self.failureAlert?(message)
                
            case .success(let response):
                self.handleEventsResponse(response, for: fetchingType)
                self.reloadEventsData?()
                self.currentPage = page
            }
            
            self.showLoading?(.none)
            self.isGettingEvents = false
        }
    }
    
    private func getPage(for fetchingType: EventsFetchingType) -> Int{
        switch fetchingType {
        case .intialize, .refresh: return 1
        case .nextPage: return currentPage + 1
        }
    }
    
    private func handleEventsResponse(_ events: [Event], for fetchingType: EventsFetchingType){
        switch fetchingType {
        case .intialize, .refresh: self.events = events
        case .nextPage: return self.events.append(contentsOf: events)
        }
    }
    
    
    func eventTypeViewModel(atRow row: Int) -> EventTypeViewModelProtocol{
        EventTypeViewModel(eventType: self.eventsTypes[row])
    }
    
    func selectEventType(atRow row: Int) {
        // Nothing happens When selecting the same type.
        guard selectedEventType?.id != eventsTypes[row].id else { return }
        
        self.selectedEventType = eventsTypes[row]
        self.reloadEventsTypesData?()
        self.getEvents(fetchingType: .intialize)
    }
    
    func isTheSelectEventType(atRow row: Int) -> Bool {
        eventsTypes[row].id == selectedEventType?.id
    }
    
    func eventViewModel(atRow row: Int) -> EventViewModelProtocol{
        EventViewModel(event: self.events[row])
    }
    
    func selectEvent(atRow row: Int){
        // TODO: Perform Navigation to Event details.
    }
    
    func nextEventsIfNeeded(at row: Int){
        guard row == numberOfEvents - 1 else { return }
        guard currentPage + 1 <= MAXIMUM_PAGES else { return }
        self.getEvents(fetchingType: .nextPage)
    }
    
    /// OutPuts
    var showLoading: ( (EventsFetchingType?) -> Void )?
    var failureAlert: ( (_ message: String) -> Void )?
    
    var reloadEventsTypesData: ( () -> Void )?
    var numberOfEventsTypes: Int { eventsTypes.count }
    
    var reloadEventsData: ( () -> Void )?
    var numberOfEvents: Int { events.count }
    
    var selectedEventType: EventType? = nil
}
