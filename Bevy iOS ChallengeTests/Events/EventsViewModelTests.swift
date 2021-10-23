//
//  EventsViewModelTests.swift
//  Bevy iOS ChallengeTests
//
//  Created by Ghalaab on 23/10/2021.
//

import XCTest
@testable import Bevy_iOS_Challenge

class EventsViewModelTests: XCTestCase {
    
    func testFetching_whenSuccess(){
        let provider = MockedEventsProvider(
            eventTypeResult: .success(EventType.mockedEventTypes), cachedEventTypes: [],
            eventsResult: .success(Event.mockedEvents), cachedEvents: [])
        let viewModel: EventsViewModelProtocol = EventsViewModel(provider: provider)
        viewModel.inputs.getEventsTypes()
        XCTAssertEqual(viewModel.outputs.numberOfEventsTypes, 2)
        XCTAssertEqual(viewModel.outputs.numberOfEvents, 4)
    }
    
    func testFetching_whenFailed(){
        let provider = MockedEventsProvider(
            eventTypeResult: .failure(NetworkError.urlGeneration), cachedEventTypes: [],
            eventsResult: .failure(NetworkError.urlGeneration), cachedEvents: [])
        let viewModel: EventsViewModelProtocol = EventsViewModel(provider: provider)
        viewModel.inputs.getEventsTypes()
        XCTAssertEqual(viewModel.outputs.numberOfEventsTypes, 0)
        XCTAssertEqual(viewModel.outputs.numberOfEvents, 0)
    }
    
    func testFetching_whenNoInternetConnection(){
        let provider = MockedEventsProvider(
            eventTypeResult: .failure(EndPointError.networkFailure(.notConnected)),
            cachedEventTypes: EventType.mockedEventTypes,
            eventsResult: .failure(EndPointError.networkFailure(.notConnected)),
            cachedEvents: Event.mockedEvents)
        let viewModel: EventsViewModelProtocol = EventsViewModel(provider: provider)
        viewModel.inputs.getEventsTypes()
        XCTAssertEqual(viewModel.outputs.numberOfEventsTypes, 2)
        XCTAssertEqual(viewModel.outputs.numberOfEvents, 4)
    }
    
    func testFetching_whenApplyingPagination(){
        let provider = MockedEventsProvider(
            eventTypeResult: .success(EventType.mockedEventTypes), cachedEventTypes: [],
            eventsResult: .success(Event.mockedEvents), cachedEvents: [])
        let viewModel: EventsViewModelProtocol = EventsViewModel(provider: provider)
        viewModel.inputs.getEventsTypes()
        viewModel.inputs.nextEventsIfNeeded(at: 3)
        
        XCTAssertEqual(viewModel.outputs.numberOfEventsTypes, 2)
        XCTAssertEqual(viewModel.outputs.numberOfEvents, 8)
    }
    
    func testFetching_whenApplyingPaginationToTheLastPage(){
        let provider = MockedEventsProvider(
            eventTypeResult: .success(EventType.mockedEventTypes), cachedEventTypes: [],
            eventsResult: .success(Event.mockedEvents), cachedEvents: [])
        let viewModel: EventsViewModelProtocol = EventsViewModel(provider: provider)
        viewModel.inputs.getEventsTypes()
        viewModel.inputs.nextEventsIfNeeded(at: 3)
        viewModel.inputs.nextEventsIfNeeded(at: 7)
        viewModel.inputs.nextEventsIfNeeded(at: 11)
        viewModel.inputs.nextEventsIfNeeded(at: 12)
        viewModel.inputs.nextEventsIfNeeded(at: 13)
        
        XCTAssertEqual(viewModel.outputs.numberOfEventsTypes, 2)
        XCTAssertEqual(viewModel.outputs.numberOfEvents, 12)
    }
    
    func testFetching_whenApplyingPaginationThenRefresh(){
        let provider = MockedEventsProvider(
            eventTypeResult: .success(EventType.mockedEventTypes), cachedEventTypes: [],
            eventsResult: .success(Event.mockedEvents), cachedEvents: [])
        let viewModel: EventsViewModelProtocol = EventsViewModel(provider: provider)
        viewModel.inputs.getEventsTypes()
        viewModel.inputs.nextEventsIfNeeded(at: 3)
        viewModel.inputs.getEvents(fetchingType: .refresh)
        
        XCTAssertEqual(viewModel.outputs.numberOfEventsTypes, 2)
        XCTAssertEqual(viewModel.outputs.numberOfEvents, 4)
    }
    
    func testFetching_whenSelectingEventType_thenSelectPreviousEventType(){
        let provider = MockedEventsProvider(
            eventTypeResult: .success(EventType.mockedEventTypes), cachedEventTypes: [],
            eventsResult: .success(Event.mockedEvents), cachedEvents: [])
        let viewModel: EventsViewModelProtocol = EventsViewModel(provider: provider)
        viewModel.inputs.getEventsTypes()
        XCTAssertEqual(viewModel.outputs.numberOfEventsTypes, 2)
        XCTAssertEqual(viewModel.outputs.numberOfEvents, 4)
        
        viewModel.inputs.nextEventsIfNeeded(at: 3)
        XCTAssertEqual(viewModel.outputs.numberOfEvents, 8)
        
        // Select Event Type
        viewModel.inputs.selectEventType(atRow: 1)
        XCTAssertEqual(viewModel.outputs.numberOfEvents, 4)
        
        // Select the Loaded Event Type
        viewModel.inputs.selectEventType(atRow: 0)
        XCTAssertEqual(viewModel.outputs.numberOfEvents, 8)
        
        XCTAssertEqual(viewModel.outputs.selectedEventItem?.eventType, EventType.mockedEventTypes.first)
    }
    
    func testFetching_thenSelectingEvent(){
        let provider = MockedEventsProvider(
            eventTypeResult: .success(EventType.mockedEventTypes), cachedEventTypes: [],
            eventsResult: .success(Event.mockedEvents), cachedEvents: [])
        let viewModel: EventsViewModelProtocol = EventsViewModel(provider: provider)
        viewModel.inputs.getEventsTypes()
        
        var eventDetailsVM: EventDetailsViewModelProtocol?
        viewModel.outputs.performEventDetailsNavigation = { eventDetailsVM = $0 }
        viewModel.inputs.selectEvent(atRow: 0)
        XCTAssertNotNil(eventDetailsVM)
    }
    
}

extension EventType{
    static var mockedEventTypes: [EventType]{
        [EventType(id: "0", name: "Test0"), EventType(id: "1", name: "Test1")]
    }
}

extension Event{
    static var mockedEvents: [Event]{
        [
            Event(id: "0", name: "Test0", description: "", cover: "",
                  startDate: "", endDate: "", latitude: "", longitude: ""),
            Event(id: "1", name: "Test1", description: "", cover: "",
                  startDate: "", endDate: "", latitude: "", longitude: ""),
            Event(id: "2", name: "Test2", description: "", cover: "",
                  startDate: "", endDate: "", latitude: "", longitude: ""),
            Event(id: "3", name: "Test3", description: "", cover: "",
                  startDate: "", endDate: "", latitude: "", longitude: "")
        ]
    }
}
