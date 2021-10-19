//
//  BaseURL.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 19/10/2021.
//

import Foundation

enum BaseURL {
    case eventtusChanllenge
    
    var value: String{
        switch self {
        case .eventtusChanllenge: return "http://private-7466b-eventtuschanllengeapis.apiary-mock.com/"
        }
    }
}
