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
    
    var selectedEventItem: EventItem? { get }
    var performEventDetailsNavigation: ( (EventDetailsViewModelProtocol) -> Void )? { get set }
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
    private var currentPage: Int = 1
    private let MAXIMUM_PAGES = 3
    private var isGettingEvents: Bool = false
    private var eventItems = [EventItem]()
    private var cachedEvents: [Event] = []
    
    init(provider: EventsProviding = EventsProvider()){
        self.provider = provider
        Monitor().startMonitoring { _ in }
    }
    
    /// Inputs
    func getEventsTypes(){
        showLoading?(.intialize)
        provider.eventsTypes(
            cached: handleEventTypesResponse,
            completion: { [weak self] result in
                guard let self = self else { return }
                self.showLoading?(.none)
                switch result{
                case .failure(let error):
                    self.handleEventTypesFailure(with: error)
                case .success(let response):
                    self.handleEventTypesResponse(response)
                    self.getEvents(fetchingType: .intialize)
                }
            }
        )
    }
    
    private func handleEventTypesFailure(with error: Error){
        if error.isInternetConnectionError{
            self.getEvents(fetchingType: .intialize)
        }else{
            let code = URLError.Code(rawValue: (error as NSError).code)
            self.failureAlert?(FAILED_LOADING_EVENTS + " \(code.rawValue) " + error.localizedDescription)
        }
    }
    
    private func handleEventTypesResponse(_ eventTypes: [EventType]){
        self.eventItems = eventTypes.map({ EventItem(eventType: $0, events: [])})
        self.selectedEventItem = eventItems.first
        self.reloadEventsTypesData?()
    }
    
    func getEvents(fetchingType: EventsFetchingType){
        guard let eventItem = selectedEventItem else { return }
        guard !isGettingEvents else { return }
        
        self.showLoading?(fetchingType)
        self.isGettingEvents = true
        let page = getPage(for: fetchingType)
        
        provider.events(eventType: eventItem.eventType, page: page, cached: {
            self.cachedEvents = $0
        }, completion: { [weak self] result in
            guard let self = self else { return }
            switch result{
            case .failure(let error):
                self.handleEventFailure(with: error)
            case .success(let response):
                self.handleEventsResponse(response, for: fetchingType)
                self.reloadEventsData?()
                self.currentPage = page
            }
            
            self.showLoading?(.none)
            self.isGettingEvents = false
        })
    }
    
    private func getPage(for fetchingType: EventsFetchingType) -> Int{
        switch fetchingType {
        case .intialize, .refresh: return 1
        case .nextPage: return currentPage + 1
        }
    }
    
    private func handleEventsResponse(_ events: [Event], for fetchingType: EventsFetchingType){
        switch fetchingType {
        case .intialize, .refresh: self.selectedEventItem?.events = events
        case .nextPage: self.selectedEventItem?.events.append(contentsOf: events)
        }
    }
    
    private func handleEventFailure(with error: Error){
        if error.isInternetConnectionError{
            self.failureAlert?(NO_INTERNEt_CONNECTION)
            if self.selectedEventItem?.events.isEmpty ?? false{
                self.selectedEventItem?.events = self.cachedEvents
                self.reloadEventsData?()
            }
        }else{
            self.failureAlert?(FAILED_LOADING_EVENTS)
        }
    }
    
    func eventTypeViewModel(atRow row: Int) -> EventTypeViewModelProtocol{
        let eventType = self.eventItems[row].eventType
        let isSelected = eventType.id == selectedEventItem?.eventType.id
        return EventTypeViewModel(eventType: self.eventItems[row].eventType, isSelected: isSelected)
    }
    
    func selectEventType(atRow row: Int) {
        // Nothing happens When selecting the same type.
        guard selectedEventItem?.eventType.id != eventItems[row].eventType.id else { return }
        
        self.selectedEventItem = eventItems[row]
        self.reloadEventsTypesData?()
        self.reloadEventsData?()
        
        if self.selectedEventItem?.events.isEmpty ?? false{
            self.getEvents(fetchingType: .intialize)
        }
    }
    
    func eventViewModel(atRow row: Int) -> EventViewModelProtocol{
        EventViewModel(event: selectedEventItem!.events[row])
    }
    
    func selectEvent(atRow row: Int){
        let viewModel = EventDetailsViewModel(event: selectedEventItem!.events[row])
        performEventDetailsNavigation?(viewModel)
    }
    
    func nextEventsIfNeeded(at row: Int){
        guard row == numberOfEvents - 1 else { return }
        guard Monitor.isconnectedToInternet else { return }
        guard currentPage + 1 <= MAXIMUM_PAGES else { return }
        self.getEvents(fetchingType: .nextPage)
    }
    
    /// OutPuts
    var showLoading: ( (EventsFetchingType?) -> Void )?
    var failureAlert: ( (_ message: String) -> Void )?
    
    var reloadEventsTypesData: ( () -> Void )?
    var numberOfEventsTypes: Int { eventItems.count }
    
    var reloadEventsData: ( () -> Void )?
    var numberOfEvents: Int { selectedEventItem?.events.count ?? 0 }
    
    var selectedEventItem: EventItem? = nil
    var performEventDetailsNavigation: ( (EventDetailsViewModelProtocol) -> Void )?
}

fileprivate let NO_INTERNEt_CONNECTION = "No internet connection"
fileprivate let FAILED_LOADING_EVENTS = "Failed loading Events"
