//
//  NetworkMonitor.swift
//  SwiftyNet
//
//  Created by Alok Choudhary on 1/4/25.
//

import Network

public final class NetworkMonitor {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitorQueue")
    public private(set) var isConnected: Bool = true
    
    public init() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = (path.status == .satisfied)
        }
        monitor.start(queue: queue)
    }
    
    deinit {
        monitor.cancel()
    }
}
