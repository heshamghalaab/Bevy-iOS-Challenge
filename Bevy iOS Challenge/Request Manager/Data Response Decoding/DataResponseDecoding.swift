//
//  DataResponseDecoding.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 19/10/2021.
//

import Foundation

protocol DataResponseDecoding {
    func decodeModel<C: Decodable>(from data: Data) throws -> C
}
