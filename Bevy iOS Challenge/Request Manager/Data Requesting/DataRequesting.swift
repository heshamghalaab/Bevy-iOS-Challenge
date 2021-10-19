//
//  DataRequesting.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 19/10/2021.
//

import Foundation

protocol DataRequesting{
    func requestData<E>(
        from endPoint: E, completionHandler: @escaping (Result<Data?, NetworkError>) -> Void
    ) where E: EndPoint
}
