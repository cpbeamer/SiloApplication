//
//  Connectivity.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation
import Alamofire
import Network

class Connectivity {
    
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    class func listner() {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            switch path.status {
            case .satisfied:
                debugPrint("We're connected!")
                if SceneDelegate.isActivedFromBackground {
                    CommonFunctions.showToastWithMessage("We're connected!")
                }
            case .unsatisfied:
                debugPrint("No connection.")
                CommonFunctions.showToastWithMessage("No connection.")
            case .requiresConnection:
                debugPrint("Connection unreachable.")
                CommonFunctions.showToastWithMessage("Connection unreachable.")
            @unknown default:
                debugPrint("unknow connection.")
                CommonFunctions.showToastWithMessage("unknow connection.")
            }
            print(path.isExpensive)
        }
        let queue = DispatchQueue.global(qos: .background)
        monitor.start(queue: queue)
    }
}
