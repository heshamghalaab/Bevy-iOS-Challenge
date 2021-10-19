//
//  EndPointError.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 19/10/2021.
//

import Foundation

enum EndPointError: Error {
    case noResponse
    case parsing(Error)
    case networkFailure(NetworkError)
    case resolvedNetworkFailure(Error)
}

protocol ConnectionError: Error {
    var isInternetConnectionError: Bool { get }
}

extension EndPointError: ConnectionError {
    public var isInternetConnectionError: Bool {
        guard case let .networkFailure(networkError) = self,
            case .notConnected = networkError else {
                return false
        }
        return true
    }
}

extension Error {
    var isInternetConnectionError: Bool {
        guard let error = self as? ConnectionError, error.isInternetConnectionError else {
            return false
        }
        return true
    }
}
