//
//  NetworkMonitor.swift
//  SwiftyNet
//
//  Created by Alok Choudhary on 1/4/25.
//

import Network

public protocol NetworkMonitoring {
    var isConnected: Bool { get }
    func startMonitoring()
    func stopMonitoring()
}

public final class NetworkMonitor: NetworkMonitoring {
    public func startMonitoring() {
        //
    }
    
    public func stopMonitoring() {
        //
    }
    
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
