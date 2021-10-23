//
//  EventType+Equatable.swift
//  Bevy iOS ChallengeTests
//
//  Created by Ghalaab on 23/10/2021.
//

import Foundation
@testable import Bevy_iOS_Challenge

extension EventType: Equatable{
    public static func == (lhs: EventType, rhs: EventType) -> Bool {
        (lhs.id == rhs.id && lhs.name == rhs.name)
    }
}
