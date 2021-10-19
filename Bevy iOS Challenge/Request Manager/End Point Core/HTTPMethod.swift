//
//  HTTPMethod.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 19/10/2021.
//

import Foundation

public struct HTTPMethod: RawRepresentable, Equatable, Hashable {
    
    public static let post = HTTPMethod(rawValue: "POST")
    public static let put = HTTPMethod(rawValue: "PUT")
    public static let get = HTTPMethod(rawValue: "GET")
    public static let head = HTTPMethod(rawValue: "HEAD")
    public static let delete = HTTPMethod(rawValue: "DELETE")
    
    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}
