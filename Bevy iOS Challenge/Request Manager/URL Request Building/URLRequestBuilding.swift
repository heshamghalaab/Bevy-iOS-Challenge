//
//  URLRequestBuilding.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 19/10/2021.
//

import Foundation

protocol URLRequestBuilding {
    func urlRequest<E>(from endPoint: E) -> URLRequest? where E : EndPoint
}
