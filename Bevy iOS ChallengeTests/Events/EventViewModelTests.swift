//
//  EventViewModelTests.swift
//  Bevy iOS ChallengeTests
//
//  Created by Ghalaab on 23/10/2021.
//

import XCTest
@testable import Bevy_iOS_Challenge

class EventViewModelTests: XCTestCase {
    
    func testViewModel_outputs(){
        let event = Event.mockedEvents.first!
        let viewModel: EventViewModelProtocol = EventViewModel(event: event)
        XCTAssertEqual(viewModel.outputs.eventName, event.name)
        XCTAssertEqual(viewModel.outputs.eventDescription, event.description)
        XCTAssertEqual(viewModel.outputs.eventDate, event.startDate)
        XCTAssertEqual(viewModel.outputs.eventImageURL, URL(string: event.cover))
    }
}
