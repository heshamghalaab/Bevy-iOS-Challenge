//
//  DataResponseHandling.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 19/10/2021.
//

import Foundation

protocol DataResponseHandling {
    func handleRequestResponse<E>(
        _ data: Data? , error: Error?, response: URLResponse?,
        from endPoint: E, completionHandler: @escaping (Result<Data?, NetworkError>) -> Void
    ) where E: EndPoint
}
