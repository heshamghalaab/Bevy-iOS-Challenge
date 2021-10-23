//
//  Monitor.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 23/10/2021.
//

import Foundation
import Network

protocol Monitoring{
    func startMonitoring(callBack: @escaping (_ isReachable: Bool) -> Void ) -> Void
    static var isconnectedToInternet: Bool { get }
}

class Monitor: Monitoring {
    private let monitor: NWPathMonitor =  NWPathMonitor()

    init() {
        let queue = DispatchQueue.global(qos: .background)
        monitor.start(queue: queue)
    }
}

extension Monitor {
    func startMonitoring(callBack: @escaping (_ isReachable: Bool) -> Void ) -> Void {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                Monitor.isconnectedToInternet = path.status == .satisfied
                callBack(Monitor.isconnectedToInternet)
            }
        }
    }
    
    func cancel() {
        monitor.cancel()
    }
    
    static var isconnectedToInternet: Bool = true
}
