//
//  Event.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 19/10/2021.
//

import Foundation

struct Event: Codable {
    let id: String
    let name: String
    let description: String
    let cover: String
    let startDate: String
    let endDate: String
    let latitude: String
    let longitude: String

    enum CodingKeys: String, CodingKey {
        case id, name, description, cover, latitude, longitude
        case startDate = "start_date"
        case endDate = "end_date"
    }
}
