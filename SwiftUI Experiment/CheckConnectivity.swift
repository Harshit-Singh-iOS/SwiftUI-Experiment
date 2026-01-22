//
//  CheckConnectivity.swift
//  SwiftUI Experiment
//
//  Created by Harshit on 1/22/26.
//

import Foundation
import Network

class ConnectivityHelper {
    let pathMonitor = NWPathMonitor()
        
    func startMonitoring() {
        pathMonitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected(currentPath: path)
            self?.networkStrength(currentPath: path)
        }
        
        
        let queue = DispatchQueue(label: "NetworkMonitor")
        pathMonitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        pathMonitor.cancel()
    }
    
    @discardableResult
    func isConnected(currentPath: NWPath) -> Bool {
        switch currentPath.status {
        case .satisfied:
            if currentPath.usesInterfaceType(.wifi) {
                print("Connected via Wi-Fi")
            } else if currentPath.usesInterfaceType(.cellular) {
                print("Connected via Cellular")
            }
            return true
        case .unsatisfied:
            print("unsatisfied network connection.")
            return false
        case .requiresConnection:
            print("requiresConnection network connection.")
            return false
        @unknown default:
            print("default network connection.")
            return false
        }
    }
    
    func networkStrength(currentPath: NWPath) {
        switch currentPath.linkQuality {
        case .unknown:
            // isConnected here
            print("unknown connection strength.")
            break
        case .minimal:
            // Perform less API calls
            print("minimal connection strength.")
            break
        case .moderate:
            // Balance data fetching
            print("moderate connection strength.")
            break
        case .good:
            // Can fetch data
            print("good connection strength.")
            break
        @unknown default:
            // isConnected
            print("default connection strength.")
            break
        }
    }
}
