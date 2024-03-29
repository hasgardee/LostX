//
//  NetworkService.swift
//  LostX
//
//  Created by Hasgar on 27/09/16.
//  Copyright © 2016 KerningLess. All rights reserved.
//

import Foundation
import SystemConfiguration

class NetworkService {
    
    static let si = NetworkService()
    private init() {}
    
    
    // MARK: Methods
    
    // Check if the device is connected to internet or not
    
    func isConnected() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)

    }
}