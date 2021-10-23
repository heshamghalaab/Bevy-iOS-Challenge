//
//  NetworkError+Equatable.swift
//  Bevy iOS ChallengeTests
//
//  Created by Ghalaab on 23/10/2021.
//

import Foundation
@testable import Bevy_iOS_Challenge

extension NetworkError: Equatable {
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.urlGeneration, .urlGeneration):
            return true
        case (.error(let lhsStatusCode, let lhsData), .error(let rhsStatusCode, let rhsData)):
            return (lhsStatusCode == rhsStatusCode && lhsData == rhsData)
        case (.notConnected, .notConnected):
            return true
        case (.generic(let lhsError), .generic(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}

