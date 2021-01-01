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
import CoreTelephony

/// This class contains every data about a SIM card.
public class FMNetworkSIMData {
    
    /** This propery returns the Mobile Country Code (MCC) of the SIM card, as a String.
    ```text
    Example:
    mcc == "208" (The MCC code for France)
    ```
     
    - Warning: This variable returns "---" (3x '-') in case the value was not found.
    */
    public var mcc: String
    
    
    /** This propery returns the Mobile Network Code (MNC) of the SIM card, as a String.
    ```text
    Example:
    mnc == "01" (The MNC code for Orange in France)
    ```
     
    - Warning: This variable returns "--" (2x '-') in case the value was not found.
    */
    public var mnc: String
    
    /** This propery returns the 2-digits uppercased ISO country code of the SIM card, as a String.
    ```text
    Example:
    land == "FR" (The 2-digits uppercased ISO country code for France)
    ```
     
    - Warning: This variable returns "--" (2x '-') in case the value was not found.
    - Attention: There is an exception for International carriers. They might return the non-standardised 2-digits code "WD", standing for World.
    - Important: This variable always return an uppercased value, do not expect a lowercased or mixed response.
    */
    public var land: String
    
    
    /** This propery returns the SIM card carrier name as found in the CTCarrier object of the SIM card
     
    - Remark: This variable is a fallback variable. It returns the name of the SIM card carrier as found in the CTCarrier object, but can also return the name of the SIM card company holder, or the name as displayed on the status bar for the matching network if any of those values were not found.
            
     
        Example:
        * name == "Orange France" (name found in the CTCarrier object)
        * fullname == "Orange France" (full name of the company behind the carrier)
        * simname == "Orange F" (network name displayed next on the status bar)
        
    The name variable fallbacks to the first value available above.
     
    - Warning: This variable returns "Carrier" in case no value was not found.
    */
    public var name: String
    
    
    /** This propery returns the SIM card status as a Boolean.
     
    - Remark: This variable is crucial. Make sure you verify that its value is equal to true before processing any data returned by the FMNetwork object.
     
    - Warning: If this variable returns false, it means the SIM card requested is currently not inserted in the device, or not in use. You might still get actual data about the SIM card from the FMNetwork object, but these come from previously inserted SIM card and should never be considered up-to-date nor accurate.
    */
    public var active: Bool
    
    
    /** This propery returns the type of the SIM card.
     
    - Note: If you requested the current SIM card, the property returned here will very likely change to .sim or .esim accordingly. In case the card.type property still returns .current on the FMNetwork object, it means FMNetwork couldn't identify the SIM card and the data returned are likely to be incorrect. Make sure you check the active property first, to make sure the SIM card is in use and therefore identified.
    */
    public var type: FMNetworkType
    
    
    /** This propery returns the list of the declared roaming PLMNs of the SIM card carrier.
            
        Example:
        * plmns == [PLMN(mcc: 208, mnc: 00), PLMN(mcc: 208, mnc: 01), PLMN(mcc: 208, mnc: 02)] (the declared roaming PLMNs for Free Mobile)
     
    - Warning: This variable returns [] (PLMN) in case no value was not found.
    */
    public var plmns: [PLMN]
    
    
    // DEPRECATED SECTION --------------------------------------
    
    
    // OBSOLETED SECTION ---------------------------------------
    
    
    // INTERNAL SECTION ----------------------------------------
    
    
    /** This propery returns the full name of the company running the SIM card carrier.
     
    - Remark: This variable is temporary and used to set the fmobile.minimalsetup property when using the FMobile API service, and therefore it is recommended to keep it internal. This variable returns the minimal setup eligibility of the carrier of the SIM card.
            
        Example:
        * eligibleminimalsetup == false (minimal setup eligibility for Free Mobile)
     
    - Warning: This variable returns true by default.
    - Important: Use fmobile.minimalsetup instead
    */
    internal var eligibleminimalsetup: Bool
    
    
    /** This propery returns the full name of the company running the SIM card carrier.
     
    - Remark: This variable is unstable and therefore it is recommended to keep it internal. This variable returns the full name of the carrier of the SIM card.
            
        Example:
        * name == "Orange France" (name detected by the CTCarrier object)
        * fullname == "Orange France" (full name of the company behind the carrier)
     
    - Warning: This variable returns "Carrier" in case the value was not found. This variable has no fallback, unlike the name property.
    - Important: Use the name propery instead.
    */
    internal var fullname: String
    
    
    /** This propery returns the SIM card carrier name as displayed on the status bar for the matching network.
     
    - Remark: This variable is unstable and therefore it is recommended to keep it internal. This variable returns the SIM card name as displayed on the status bar for the matching network.
            
        Example:
        * name == "Orange France" (name detected by the CTCarrier object)
        * simname == "Orange F" (network name displayed next on the status bar)
     
    - Warning: This variable returns "Carrier" in case the value was not found. This variable has no fallback, unlike the name property.
    - Important: Use the name propery instead.
    */
    internal var simname: String
    
    
    /// - Attention: This variable should stay internal. It contains the raw mcc and mnc of the SIM card grouped together. When no mcc or mnc was found, the current return value is "-----" (5x '-').
    internal var data: String
    
    
    /// - Attention: This variable should stay internal. It contains the raw CTCarrier object for the requested SIM card. It is used to extract data about the SIM card, but is not intended to be available on the FMNetwork object.
    internal var carrier: CTCarrier
    
    
    
    /// - Attention: This function should stay internal. It intitializes the class, but is intended to be called while generating an FMNetwork object. This function is not supposed to be called separetly.
    /// - Parameters:
    ///   - mcc: mcc to add to the object
    ///   - mnc: mnc to add to the object
    ///   - land: land to add to the object
    ///   - name: name to add to the object
    ///   - fullname: fullname to add to the object
    ///   - data: data to add to the object
    ///   - simname: simname to add to the object
    ///   - carrier: carrier to add to the object
    ///   - active: active status to add to the object
    ///   - type: type to add to the object
    internal init(mcc: String = String(), mnc: String = String(), land: String = String(), name: String = String(), fullname: String = String(), data: String = String(), simname: String = String(), carrier: CTCarrier = CTCarrier(), active: Bool = false, type: FMNetworkType = .sim, plmns: [PLMN] = [PLMN](), eligibleminimalsetup: Bool = true) {
        self.mcc = mcc
        self.mnc = mnc
        self.land = land
        self.name = name
        self.fullname = fullname
        self.simname = simname
        self.data = data
        self.carrier = carrier
        self.active = active
        self.type = type
        self.plmns = plmns
        self.eligibleminimalsetup = eligibleminimalsetup
    }
    
}
