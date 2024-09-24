//
//  NetworkManager.swift
//  Movie App
//
//  Created by Bthloo on 24/09/2024.
//

import Network
import UIKit

class NetworkManager {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    static let shared = NetworkManager() // Singleton instance
    var isConnected: Bool = false

    private init() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { path in
            self.isConnected = (path.status == .satisfied)
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: .didChangeNetworkStatus, object: nil, userInfo: ["isConnected": self.isConnected])
            }
        }
    }

    func checkConnection() -> Bool {
        return isConnected
    }

    deinit {
        monitor.cancel()
    }
}

extension Notification.Name {
    static let didChangeNetworkStatus = Notification.Name("didChangeNetworkStatus")
}
