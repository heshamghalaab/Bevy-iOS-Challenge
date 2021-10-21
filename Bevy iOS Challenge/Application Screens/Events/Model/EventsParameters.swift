//
//  EventsParameters.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 19/10/2021.
//

import Foundation

struct EventsParameters: Encodable {
    let eventType: String
    let page: Int
    
    enum CodingKeys: String, CodingKey {
        case eventType = "event_type"
        case page
    }
}
