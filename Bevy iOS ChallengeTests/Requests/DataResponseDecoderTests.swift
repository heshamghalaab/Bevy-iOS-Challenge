//
//  DataResponseDecoderTests.swift
//  Bevy iOS ChallengeTests
//
//  Created by Ghalaab on 23/10/2021.
//

import XCTest
@testable import Bevy_iOS_Challenge

class DataResponseDecoderTests: XCTestCase {
       
    func testDecodeJSSON_whenTheJsonIsValid() {
        let eventType = EventType(id: "0", name: "Test")
        var expectedData: Data!
        
        do {
            expectedData = try JSONEncoder().encode(eventType)
        } catch  {
            XCTFail("Failed To Encode")
        }
        
        let dataResponseDecoder: DataResponseDecoding = DataResponseDecoder()
        do {
            let model: EventType = try dataResponseDecoder.decodeModel(from: expectedData)
            XCTAssertEqual(model, eventType)
        } catch  {
            XCTFail("Shouldn't have called")
        }
    }
    
    func testDecodeJSON_whenTheJsonIsInvalid() {
        var expectedData: Data!
        
        do {
            expectedData = try JSONSerialization.data(withJSONObject: [["id": 0]], options: .prettyPrinted)
        } catch  {
            XCTFail("Failed to archived Data")
        }
        
        let dataResponseDecoder: DataResponseDecoding = DataResponseDecoder()
        do {
            let _: EventType = try dataResponseDecoder.decodeModel(from: expectedData)
            XCTFail("Shouldn't have called")
        } catch  { }
    }
}

