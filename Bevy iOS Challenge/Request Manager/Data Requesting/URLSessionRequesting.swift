//
//  URLSessionRequesting.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 19/10/2021.
//

import Foundation

protocol URLSessionRequesting {
    func dataTask(
        with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask
}

extension URLSession: URLSessionRequesting { }
