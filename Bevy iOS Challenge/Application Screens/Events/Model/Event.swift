//
//  Event.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 19/10/2021.
//

import Foundation

struct Event: Codable {
    var id: String
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
    
    
    /// To Make Sure that the Id is unique.
    ///
    /// Because of the dublications that happens in the data and we need the id to be unique in order to make operations in core data or in cashing we have to concatunate the event type and the page to the Id.
    mutating func makeEventIdUnique(withEventType eventType: String, page: Int){
        self.id += ("--EventType:" + eventType + "/Page:" + page.description)
    }
    
    func removeExtraValueFromId() -> String {
        if let range = id.range(of: "--"){
            return String(id[..<range.lowerBound])
        }
        return id
    }
}
