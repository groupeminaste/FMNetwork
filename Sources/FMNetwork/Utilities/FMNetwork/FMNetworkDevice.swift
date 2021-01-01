/*
 *  Copyright (C) 2021 Groupe MINASTE
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 *
 */
//
//  FMNetworkDevice.swift
//  FMobile
//
//  Created by PlugN on 01/07/2020.
//  Copyright © 2020 Groupe MINASTE. All rights reserved.
//

import Foundation
import CoreTelephony
import CallKit
import SystemConfiguration.CaptiveNetwork
import NetworkExtension

/// This class contains every data about the device, independently from the mobile network.
public class FMNetworkDevice {

    
    /// This property contains the data of the currently connected Wi-Fi Network.  If the property is not nil, it means the device is connected to a Wi-Fi Network. You can use that property in combination with the isConnectedToNetwork() function to determine whether the device is using cellular data, however be aware that you will not be 100% sure that the device will be using cellular data, as Bluetooth and Ethernet adapters are also possible network connection sources. Defaults to nil.
    /// - Attention: This property requires the "Access Wifi Information" capability enabled on your target, as well as an authorized access to location to be initialized properly. The property being nil does not mean that the device is disconnected from the Wi-Fi network if these requirements are not satisfied.
    /// - Warning: Prior to iOS 14.0, only the SSID and BSSID values are available. Make sure you check that the detailedDataAvailable variable equals true before reading any other variable.
    public var currentWifiNetwork: WIFI?
    
    /// This property is equal true if a phone call is detected, whether it is using the mobile network, or Internet VoIP services using CallKit.
    public var isOnPhoneCall: Bool
    
    /// This property is equal true if the device is connected to Internet, no matter how. You can use that property in combination with the currentWifiNetwork property to determine whether the device is using cellular data, however be aware that you will not be 100% sure that the device will be using cellular data, as Bluetooth and Ethernet adapters are also possible network connection sources.
    public var isConnectedToNetwork: Bool
    
    /// This property stores the Boolean value of whether the device is in Airplane Mode or not.
    public var isOnAirplaneMode: Bool
    
    
    // DEPRECATED SECTION --------------------------------------
    
    
    // OBSOLETED SECTION ---------------------------------------
    
    
    // INTERNAL SECTION ----------------------------------------
    
    
    /// This function returns true if a phone call is detected, whether it is using the mobile network, or Internet VoIP services using CallKit.
    /// - Returns: The Boolean phone call status. Defaults to false.
    internal class func isOnPhoneCall() -> Bool {
        if #available(iOS 10.0, *) {
            for call in CXCallObserver().calls {
                if call.hasEnded == false {
                    return true
                }
            }
        } else {
            let callCenter = CTCallCenter()
            for call in callCenter.currentCalls ?? [] {
                if call.callState == CTCallStateConnected {
                    return true
                }
            }
        }
        return false
    }
    
    /// This function returns true if the device is connected to Internet, no matter how. You can use that function in combination with the isWifiConnected() function to determine whether the device is using cellular data, however be aware that you will not be 100% sure that the device will be using cellular data, as Bluetooth and Ethernet adapters are also possible network connection sources.
    /// - Returns: The Boolean Internet connection status. Returns false by default.
    internal class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        if let defaultRouteReachability = defaultRouteReachability {
            var flags : SCNetworkReachabilityFlags = []

            if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
                return false
            }
            
            let isReachable = flags.contains(.reachable)
            let needsConnection = flags.contains(.connectionRequired)
            return (isReachable && !needsConnection)
        }
        
        return false
    }
    
    /// This function returns whether the device is in Airplane Mode or not.
    /// - Returns: The Boolean Airplane Mode toggle status. Returns false by default.
    internal class func isOnAirplaneMode() -> Bool {
        let urlairplane = URL(fileURLWithPath: "/var/preferences/SystemConfiguration/com.apple.radios.plist")
        do {
            let test: NSDictionary
            if #available(iOS 11.0, *) {
                test = try NSDictionary(contentsOf: urlairplane, error: ())
            } else {
                test = NSDictionary(contentsOf: urlairplane) ?? NSDictionary()
            }
            let airplanemode = test["AirplaneMode"] as? Bool ?? false
            return airplanemode
        } catch {
            return false
        }
    }
    
    
    /// - Attention: This function should stay internal. It is used to fetch the current Wi-Fi data, and should not be called outside of the class. Please refer to the corresponding public functions to fetch the data you need.
    /// - Returns: status: The boolean value indicating whether the Wi-Fi is connected or not (defaults to false), ssid, bssid and ssiddata as String (defaults to "")
    @available (iOS, obsoleted: 14.0)
    internal class func getWifiDataOlder() -> (status: Bool, ssid: String, bssid: String) {
        if let interface = CNCopySupportedInterfaces() {
            for i in 0 ..< CFArrayGetCount(interface) {
                let interfaceName: UnsafeRawPointer = CFArrayGetValueAtIndex(interface, i)
                let rec = unsafeBitCast(interfaceName, to: AnyObject.self)
                if let unsafeInterfaceData = CNCopyCurrentNetworkInfo("\(rec)" as CFString), let interfaceData = unsafeInterfaceData as? [String : AnyObject] {
                    return (true, interfaceData["SSID"] as? String ?? "", interfaceData["BSSID"] as? String ?? "")
                } else {
                    print("Not connected to wifi.")
                    return (false, "", "")
                }
            }
        }
        return (false, "", "")
    }
    
    /// - Attention: This function should stay internal. It intitializes the class, but is intended to be called while generating an FMNetwork object. This function is not supposed to be called separetly.
    internal init() {
        
        self.isOnPhoneCall = FMNetworkDevice.isOnPhoneCall()
        self.isOnAirplaneMode = FMNetworkDevice.isOnAirplaneMode()
        self.isConnectedToNetwork = FMNetworkDevice.isConnectedToNetwork()
        
        if #available(iOS 14.0, *) {
            NEHotspotNetwork.fetchCurrent { (network) in
                if let network = network {
                    self.currentWifiNetwork = WIFI(network: network)
                }
            }
        } else {
            let wifiData = FMNetworkDevice.getWifiDataOlder()
            if wifiData.status && wifiData.bssid != "" && wifiData.bssid != "00:00:00:00:00:00" {
                self.currentWifiNetwork = WIFI(ssid: wifiData.ssid, bssid: wifiData.bssid)
            }
        }
    }
    
}
