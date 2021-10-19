//
//  DataResponseDecoder.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 19/10/2021.
//

import Foundation

struct DataResponseDecoder: DataResponseDecoding {
    func decodeModel<C: Decodable>(from data: Data) throws -> C {
        return try JSONDecoder().decode(C.self, from: data)
    }
}
