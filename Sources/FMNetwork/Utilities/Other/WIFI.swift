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
//  WIFI.swift
//  FMNetwork
//
//  Created by PlugN on 01/01/2021.
//  Copyright © 2021 Groupe MINASTE. All rights reserved.
//

import Foundation
import NetworkExtension

public class WIFI {
    
    /// The String name (SSID) for the Wi-Fi Network.
    public var ssid: String
    
    /// The String ID (BSSID) for the Wi-Fi Network.
    public var bssid: String
    
    /// The Boolean value indicating if more detailed data are available. If this value is equal to false, you should only read the SSID and BSSID values. Prior to iOS 14.0, this value will always be false.
    public var detailedDataAvailable: Bool
    
    /// The Double Signal Strength for the Wi-Fi Network.
    /// - Warning: Prior to iOS 14.0, only the SSID and BSSID values are available. Make sure you check that the detailedDataAvailable variable equals true before reading any other variable.
    public var signalStrength: Double
    
    /// The Boolean Security status for the Wi-Fi Network.
    /// - Warning: Prior to iOS 14.0, only the SSID and BSSID values are available. Make sure you check that the detailedDataAvailable variable equals true before reading any other variable.
    public var isSecure: Bool
    
    /// The Boolean Auto Join status for the Wi-Fi Network.
    /// - Warning: Prior to iOS 14.0, only the SSID and BSSID values are available. Make sure you check that the detailedDataAvailable variable equals true before reading any other variable.
    public var didAutoJoin: Bool
    
    /// The Boolean Just Joined status for the Wi-Fi Network.
    /// - Warning: Prior to iOS 14.0, only the SSID and BSSID values are available. Make sure you check that the detailedDataAvailable variable equals true before reading any other variable.
    public var didJustJoin: Bool
    
    /// The Boolean Choosen Helper status for the Wi-Fi Network. This applies only if your application works with this specific NEHotspotNetwork as a Helper. Otherwise, it returns false.
    /// - Warning: Prior to iOS 14.0, only the SSID and BSSID values are available. Make sure you check that the detailedDataAvailable variable equals true before reading any other variable.
    public var isChoosenHelper: Bool
    
    
    // DEPRECATED SECTION --------------------------------------
    
    
    // OBSOLETED SECTION ---------------------------------------
    
    
    // INTERNAL SECTION ----------------------------------------
    
    
    /// - Attention: This function should stay internal. It intitializes the class, but is intended to be called while generating an FMNetwork object. This function is not supposed to be called separetly.
    /// - Parameters:
    ///   - ssid: The SSID of the Wi-Fi network
    ///   - bssid: The BSSID of the Wi-Fi Network
    internal init(ssid: String, bssid: String) {
        self.ssid = ssid
        self.bssid = bssid
        self.detailedDataAvailable = false
        self.signalStrength = 0
        self.isSecure = false
        self.didAutoJoin = false
        self.didJustJoin = false
        self.isChoosenHelper = false
    }
    
    
    /// - Attention: This function should stay internal. It intitializes the class, but is intended to be called while generating an FMNetwork object. This function is not supposed to be called separetly.
    /// - Parameter network: The NEHotspotNetwork object (for iOS 14.0+)
    internal init(network: NEHotspotNetwork) {
        self.ssid = network.ssid
        self.bssid = network.bssid
        self.detailedDataAvailable = true
        self.signalStrength = network.signalStrength
        self.isSecure = network.isSecure
        self.didAutoJoin = network.didAutoJoin
        self.didJustJoin = network.didJustJoin
        self.isChoosenHelper = network.isChosenHelper
    }
}
