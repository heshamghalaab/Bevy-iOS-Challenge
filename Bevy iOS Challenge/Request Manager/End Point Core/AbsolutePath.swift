//
//  AbsolutePath.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 19/10/2021.
//

import Foundation

enum AbsolutePath {
    case eventtusChanllenge(EventtusChanllenge)
    
    var value: String{
        switch self {
        case .eventtusChanllenge(let path): return path.value
        }
    }
}

enum EventtusChanllenge{
    
    case eventTypes
    case events
    
    var value: String{
        switch self {
        case .eventTypes: return "eventtypes"
        case .events: return "events"
        }
    }
}
