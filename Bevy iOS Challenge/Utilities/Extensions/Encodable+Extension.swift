//
//  Encodable+Extension.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 19/10/2021.
//

import Foundation

extension Encodable {
    var asDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
