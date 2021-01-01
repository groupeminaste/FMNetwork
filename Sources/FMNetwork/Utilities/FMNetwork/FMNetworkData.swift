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
//  FMNetworkData.swift
//  FMobile
//
//  Created by PlugN on 01/07/2020.
//  Copyright © 2020 Groupe MINASTE. All rights reserved.
//

import Foundation

/// This class contains every data about the connected network of a SIM card.
public class FMNetworkData {
    
    /** This propery returns the Mobile Country Code (MCC) of the connected network, as a String.
    ```text
    Example:
    mcc == "311" (The MCC code for the United States of America)
    ```
    - Attention: This variable is a fallback variable. This variable can fallback to the SIM card MCC in case the value was not found.
    - Warning: This variable returns "---" (3x '-') in case no value was found.
    */
    public var mcc: String
    
    
    /** This propery returns the Mobile Network Code (MNC) of the connected network, as a String.
    ```text
    Example:
    mcc == "480" (The MNC code for Verizon, in the United States of America)
    ```
     - Attention: This variable is a fallback variable. This variable can fallback to the SIM card MCC in case the value was not found.
    - Warning: This variable returns "--" (2x '-') in case no value was found.
    */
    public var mnc: String
    
    
    /** This propery returns the 2-digits uppercased ISO country code of the connected network, as a String.
    ```text
    Example:
    land == "US" (The 2-digits uppercased ISO country code for the United States of America)
    ```
     
    - Warning: This variable returns "--" (2x '-') in case the value was not found.
    - Attention: There is an exception for International carriers. They might return the non-standardised 2-digits code "WD", standing for World.
    - Important: This variable always return an uppercased value, do not expect a lowercased or mixed response.
    */
    public var land: String
    
    
    /** This propery returns the connected network name as found on the status bar.
     
    - Remark: This variable is a fallback variable. It returns the name of the connected network name as found on the status bar, but can also return the name of the connected network company holder if the value was not found.
            
     
        Example:
        * name == "Verizon" (name found on the status bar)
        * fullname == "Verizon" (full name of the company behind the connected network)
        
    The name variable fallbacks to the first value available above.
     
    - Warning: This variable returns "Carrier" in case no value was not found.
    */
    public var name: String
    
    
    /** This propery returns the connected network protocol, as a CTRadioAccessTechnology constant.
     
    - Remark: This variable is a String, but to decode it safely, it is highly recommended to read it as a Core Telephony constant.
        
     
        Exhaustive list of the current Core Telephony constants:
        * 5G:
            * CTRadioAccessTechnologyNR
            * CTRadioAccessTechnologyNRNSA
        * 4G:
            * CTRadioAccessTechnologyLTE
        * 3G (GSM):
            * CTRadioAccessTechnologyWCDMA
            * CTRadioAccessTechnologyHSDPA
            * CTRadioAccessTechnologyeHRPD
            * CTRadioAccessTechnologyHSUPA
        * 3G (CDMA):
            * CTRadioAccessTechnologyCDMA1x
            * CTRadioAccessTechnologyCDMAEVDORev0
            * CTRadioAccessTechnologyCDMAEVDORevA
            * CTRadioAccessTechnologyCDMAEVDORevB
        * 2G:
            * CTRadioAccessTechnologyEdge
        * 1G:
            * CTRadioAccessTechnologyGPRS
             
    Please refer to the Core Telephony constants documentation for more informations. [More informations here](https://developer.apple.com/documentation/coretelephony/cttelephonynetworkinfo/radio_access_technology_constants)
     
    - Warning: This variable returns "" (empty String) in case no value was not found.
    - Attention: These values are decodable as String values and will likely have the share the same raw values as the one listed above. However, as Apple might change these raw values in future OS updates, it is better to use the Core Telephony constants that will handle the change of the raw values for you, automatically. Using Core Telephony constants make your project future-proof.
    # code
    ```
    import CoreTelephony
    // ...
    if (connected == CTRadioAccessTechnologyLTE) {
        // ... (connected to 4G LTE)
    }
    ```
    */
    public var connected: String
    
    
    
    // DEPRECATED SECTION --------------------------------------
    
    
    // OBSOLETED SECTION ---------------------------------------
    
    
    // INTERNAL SECTION ----------------------------------------
    
    
    /** This propery returns the full name of the company running the connected network.
     
    - Remark: This variable is unstable and therefore it is recommended to keep it internal. This variable returns the full name of the carrier of the connected network.
            
        Example:
        * name == "Verizon" (name detected on the status bar)
        * fullname == "Verizon" (full name of the company behind the connected network)
     
    - Warning: This variable returns "Carrier" in case the value was not found. This variable has no fallback, unlike the name property.
    - Important: Use the name propery instead.
    */
    internal var fullname: String
    
    
    /// - Attention: This variable should stay internal. It contains the raw mcc and mnc of the connected network grouped together. When no mcc or mnc was found, the current return value is "-----" (5x '-').
    internal var data: String
    
    
    
    /// - Attention: This function should stay internal. It intitializes the class, but is intended to be called while generating an FMNetwork object. This function is not supposed to be called separetly.
    /// - Parameters:
    ///   - mcc: mcc to add to the object
    ///   - mnc: mnc to add to the object
    ///   - land: land to add to the object
    ///   - name: name to add to the object
    ///   - fullname: fullname to add to the object
    ///   - data: data to add to the object
    ///   - connected: connected protocol to add to the object
    internal init(mcc: String = String(), mnc: String = String(), land: String = String(), name: String = String(), fullname: String = String(), data: String = String(), connected: String = String()) {
        self.mcc = mcc
        self.mnc = mnc
        self.land = land
        self.name = name
        self.fullname = fullname
        self.data = data
        self.connected = connected
    }
    
}
