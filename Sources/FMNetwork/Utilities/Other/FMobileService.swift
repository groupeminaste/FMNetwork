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
//  FMobileService.swift
//  FMobile
//
//  Created by Nathan FALLET on 01/09/2019.
//  Copyright © 2019 Groupe MINASTE. All rights reserved.
//

import Foundation
import APIRequest
import UIKit
import CoreTelephony

/// This class contains optional complementary data about a SIM card provided by the FMobile API service.
public class FMobileService: Codable {
    
    /** This propery returns the Mobile Country Code (MCC) of the SIM card, as declared at the FMobile API service, as a String.
    ```text
    Example:
    mcc == "208" (The MCC for France)
    ```
     
    - Warning: This variable returns nil in case the value was not found.
    */
    public var mcc: String?
    
    /** This propery returns the Mobile Network Code (MNC) of the SIM card, as declared at the FMobile API service, as a String.
    ```text
    Example:
    mcc == "15" (The MNC for Free Mobile, in France)
    ```
     
    - Warning: This variable returns nil in case the value was not found.
    */
    public var mnc: String?
    
    /** This propery returns the maximum speed of the SIM card while connected on a national roaming network, in Mbps, as declared at the FMobile API service, as a Double.
    ```text
    Example:
    stms == 0.384 (The maximum speed for Free Mobile, while connected on Orange France's network)
    ```
    - Attention: If you are dealing with national roaming, it would be best to check that the disableFMobileCore property is equal to false first.
    - Warning: This variable will likely return 5000 by default, but can also return nil in case something went wrong.
    */
    public var stms: Double?
    
    /** This propery returns the 3G "home protocol", meaning the protocol on which the connected network is more likely not to be roaming nationally, as declared at the FMobile API service, as a String.
    ```text
    Example:
    import CoreTelephony
    hp == CTRadioAccessTechnologyWCDMA (The home protocol for Free Mobile)
    ```
     
    - Attention: The hp variable conforms to the CoreTelephony constants.
    - Warning: This variable will likely return CTRadioAccessTechnologyWCDMA by default, but can also return nil in case something went wrong.
    */
    public var hp: String?
    
    /** This propery returns the 3G "national roaming protocol", meaning the protocol on which the connected network is more likely to be roaming nationally, as declared at the FMobile API service, as a String.
    ```text
    Example:
    import CoreTelephony
    hp == CTRadioAccessTechnologyHSDPA (The national roaming protocol for Free Mobile)
    ```
     
    - Attention: The nrp variable conforms to the CoreTelephony constants.
    - Warning: This variable will likely return CTRadioAccessTechnologyHSDPA by default, but can also return nil in case something went wrong.
    */
    public var nrp: String?
    
    /** This propery returns the 2-digit ISO country code, as declared at the FMobile API service, as a String.
    ```text
    Example:
    land == "FR" (The 2-digit ISO country code for France)
    ```
    
    - Attention: If you are dealing with national roaming, it would be best to check that the disableFMobileCore property is equal to false first.
    - Warning: This variable has no determined default value, but can still return nil in case something went wrong.
    */
    public var land: String?
    
    /** This propery returns the name of the national roaming network, as declared at the FMobile API service, as a String.
    ```text
    Example:
    itiname == "Orange F" (The name of the national roaming network for Free Mobile)
    ```
     
    - Attention: If you are dealing with national roaming, it would be best to check that the disableFMobileCore property is equal to false first.
    - Warning: This variable will likely return the same value as homename by default, but can also return nil in case something went wrong.
    */
    public var itiname: String?
    
    /** This propery returns the name of the home network for the SIM card, as declared at the FMobile API service, as a String.
    ```text
    Example:
    homename == "Free" (The name of the home network for Free Mobile)
    ```
     
    - Warning: This variable has no determined default value, but can still return nil in case something went wrong.
    */
    public var homename: String?
    
    /** This propery returns the Mobile Network Code (MNC) of the national roaming network, as declared at the FMobile API service, as a String.
    ```text
    Example:
    itimnc == "01" (The MNC of the national roaming network for Free Mobile)
    ```
     
    - Attention: If you are dealing with national roaming, it would be best to check that the disableFMobileCore property is equal to false first.
    - Warning: This variable will likely return "99" by default, but can also return nil in case something went wrong.
    */
    public var itimnc: String?
    
    /** This propery returns the activation status of a Femtocell network using the same 3G radio technology as the national roaming network (nrp), as declared at the FMobile API service, as a Bool.
    ```text
    Example:
    nrfemto == true (The current Femtocell status for Free Mobile)
    ```
     
    - Attention: If you are dealing with national roaming, it would be best to check that the disableFMobileCore property is equal to false first.
    - Warning: This variable will likely return false by default, but can also return nil in case something went wrong.
    */
    public var nrfemto: Bool?
    
    /** This propery returns the lack of a 2G network for the home network, as declared at the FMobile API service, as a Bool.
    ```text
    Example:
    out2G == true (The current 2G network lack for Free Mobile)
    ```
     
    - Warning: This variable will likely return false by default, but can also return nil in case something went wrong.
    */
    public var out2G: Bool?
    
    /** This propery returns the FMobile CarrierConfiguration status, as declared at the FMobile API service, as a Bool.
    ```text
    Example:
    setupDone == true (The current setup status for Free Mobile)
    ```
     
    - Attention: In case this property returns false, it means manual setup is required and some crucial fields are missing. You will need to fill them by hand.
    - Warning: This variable will likely return true by default, but can also return nil in case something went wrong.
    */
    public var setupDone: Bool?
    
    /** This propery returns the minimal setup status, as declared at the FMobile API service, as a Bool.
    ```text
    Example:
    minimalSetup == false (The current minimal setup status for Free Mobile)
    ```
     
    - Attention: In case this property returns false, it means the national roaming is not immediately detectable by the FMNetwork core, and will require extra work and process to detect the national roaming. This property is used in the FMobile G3 engine to properly select which national roaming detection method to use (when false, will require a speedtest using the stms property).
    - Warning: This variable will likely return true by default, but can also return nil in case something went wrong.
    */
    public var minimalSetup: Bool?
    
    /** This propery returns whether the FMobile core engine for detecting national roaming should be turned off, as declared at the FMobile API service, as a Bool.
    ```text
    Example:
    disableFMobileCore == false (The current core disabling status for Free Mobile)
    ```
     
    - Attention: In case this property returns true, it means that the carrier does not have a national roaming agreement, and invalidates some of the other values you might recieve. Therefore, if you are dealing with national roaming, it would be best to check that the value of this property is equal to false first.
    - Warning: This variable will likely return true by default, but can also return nil in case something went wrong.
    */
    public var disableFMobileCore: Bool?
    
    /** This propery returns the list of 2-digit ISO country codes included in the SIM cards plan for Cellular Data-only connectivity at no extra charge for a vast majority of plans, as declared at the FMobile API service, as a \[String\].
    ```text
    Example:
    countriesData == ["DZ", "AR", "AM", "BD", "BY", "BR", "CN", "GE", "GG", "IM", "IN", "JE", "KZ", "MK", "MY", "MX", "ME", "UZ", "PK", "RU", "RS", "LK", "CH", "TH", "TN", "TR", "UA"] (The current included 2-digit ISO country codes in Cellular Data-only, for Free Mobile)
    ```
     
    - Attention: The countriesVData property is the list including voice and data, and should be considered first. The API does not repeat the destinations twice in multiple categories. You might find the EU or UE 2-digit non-standard ISO codes in the list, be prepared to ignore them, as they are not valuable, and have the only purpose to simplify the API data transmission (they have already been decoded, so you can safely ignore or override them).
    - Warning: This variable returns nil in case the value was not found.
    */
    public var countriesData: [String]?
    
    /** This propery returns the list of 2-digit ISO country codes included in the SIM cards plan for voice calls-only (no data) at no extra charge for a vast majority of plans, as declared at the FMobile API service, as a \[String\].
    ```text
    Example:
    countriesVoice == ["PM"] (The current included 2-digit ISO country codes in voice-only, for Free Mobile)
    ```
     
    - Attention: The countriesVData property is the list including voice and data, and should be considered first. The API does not repeat the destinations twice in multiple categories. You might find the EU or UE 2-digit non-standard ISO codes in the list, be prepared to ignore them, as they are not valuable, and have the only purpose to simplify the API data transmission (they have already been decoded, so you can safely ignore or override them).
    - Warning: This variable returns nil in case the value was not found.
    */
    public var countriesVoice: [String]?
    
    /** This propery returns the list of 2-digit ISO country codes included in the SIM cards plan for Cellular Data and Voice communications at no extra charge for a vast majority of plans, as declared at the FMobile API service, as a \[String\].
    ```text
    Example:
    countriesVData == ["EU", "GB", "ZA", "AU", "CA", "US", "IL", "NZ"] (The current included 2-digit ISO country codes in Voice and Data, for Free Mobile)
    ```
     
    - Attention: The countriesVData property is the list including voice and data, and should be considered first. The API does not repeat the destinations twice in multiple categories. You might find the EU or UE 2-digit non-standard ISO codes in the list, be prepared to ignore them, as they are not valuable, and have the only purpose to simplify the API data transmission (they have already been decoded, so you can safely ignore or override them).
    - Warning: This variable returns nil in case the value was not found.
    */
    public var countriesVData: [String]?
    
    /** This propery returns the list of Carrier Services, as declared at the FMobile API service, as a \[\[String, String, String\]\]. The Carrier Services structure should be read like this : (Service Name, URL, Action code).
     
    The action codes available are the following, each of these are supposed to open the given URL, and display the given name:
    * open_official_app (to open the official SIM card carrier's app)
    * open (to open any app or link)
    * copy_callcode (to copy or call an USSD code)
    * call_conso (to call the consumption tracking number)
    * call_service (to call the customer service)
     
    ```text
    Example:
    carrierServices == [["Suivi Conso CFM", "shortcuts://run-shortcut?name=CFM", "open"], ["555", "tel://555", "call_conso"], ["3244", "tel://3244", "call_service"]] (The current included 2-digit ISO country codes in Voice and Data, for Free Mobile)
    ```
     
    - Warning: This variable returns nil in case the value was not found.
    */
    public var carrierServices: [[String]]?
    
    /** This propery returns the status of 4G LTE national roaming, as declared at the FMobile API service, as a \[String\].
    ```text
    Example:
    roamLTE == false (The current 4G LTE national roaming status for Free Mobile)
    ```
     
    - Warning: This variable returns nil in case the value was not found.
    */
    public var roamLTE: Bool?
    
    /** This propery returns the status of 5G national roaming, as declared at the FMobile API service, as a \[String\].
    ```text
    Example:
    roam5G == false (The current 5G national roaming status for Free Mobile)
    ```
     
    - Warning: This variable returns nil in case the value was not found.
    */
    public var roam5G: Bool?
    
    /** This propery returns the Mobile Network Code (MNC) used to detect the national roaming network, as declared at the FMobile API service, as a String. It may be equal to mnc or itimnc, depending on the nrdec property. If nrdec is equal to true, chasedmnc will be equal to mnc and you will need to do a speedtest in order to detect the national roaming.
    ```text
    Example:
    chasedmnc == "15" (The MNC used to detect national roaming network for Free Mobile)
    ```
     
    - Attention: If you are dealing with national roaming, it would be best to check that the disableFMobileCore property is equal to false first.
    - Attention: If chasedmnc is equal to mnc, you will need to do a speedtest in order to detect the national roaming.
    - Warning: This variable will likely return mnc by default, but can also return nil in case something went wrong.
    */
    public var chasedmnc: String?
    
    /** This propery returns the national roaming declaration status of the SIM card carrier, as a Bool.
     
     ```text
     Example:
     nrdec == true (The national roaming declaration status for Free Mobile)
     ```
  
     - Warning: If nrdec is equal to true, the roaming network is declared and chasedmnc will be equal to mnc, so you will need to do a speedtest in order to detect the national roaming. This variable returns nil in case something went wrong.
     */
    public var nrdec: Bool?
    
    // DEPRECATED SECTION --------------------------------------
    
    
    // OBSOLETED SECTION ---------------------------------------
    
    
    // INTERNAL SECTION ----------------------------------------
    
    /// - Attention: This variable should stay internal. This propery overrides all the given properties specifically for iPad, as declared at the FMobile API service, but is not intended to be available on the FMobileService object.
    internal var iPadOverwrite: [String:AnyCodable]?
    
    /// - Attention: This function should stay internal. It is used to initialize the class, but is intended to be called while generating an FMNetwork object using the FMobile API service. This function is not supposed to be called separetly.
    /// Initialize the class using the FMobile API service. This function requires an active Internet connection to work properly. Keep in mind the FMobile API service requires an active Internet connection, and is working in async. You are fully responsible of the mobile data consumed by this function. The function returns through a completionHandler the object, meant to be inserted in the FMNetwork property.
    /// - Parameters:
    ///   - mcc: The SIM card's Mobile Country Code (MCC)
    ///   - mnc: The SIM card's Mobile Network Code (MNC)
    ///   - completionHandler: Async completion, requires an active Internet connection to work properly
    /// - Returns: The FMobileService object, or nil if something went wrong
    internal static func fetch(forMCC mcc: String, andMNC mnc: String, completionHandler: @escaping (FMobileService?) -> ()) {
        
        APIConfiguration.current = APIConfiguration(host: "fmobileapi.groupe-minaste.org")
        
        APIRequest("GET", path: "/public/carrierlist/\(mcc)-\(mnc).json").execute(FMobileService.self) { data, _ in
            if let configuration = data, configuration.mcc == mcc, configuration.mnc == mnc {
                
                if UIDevice.current.userInterfaceIdiom == .pad {
                    if let mcc = configuration.iPadOverwrite?["mcc"]?.value() as? String {
                        configuration.mcc = mcc
                    }
                    if let mnc = configuration.iPadOverwrite?["mnc"]?.value() as? String {
                        configuration.mnc = mnc
                    }
                    if let stms = configuration.iPadOverwrite?["stms"]?.value() as? Double {
                        configuration.stms = stms
                    }
                    if let hp = configuration.iPadOverwrite?["hp"]?.value() as? String {
                        configuration.hp = hp
                    }
                    if let nrp = configuration.iPadOverwrite?["nrp"]?.value() as? String {
                        configuration.nrp = nrp
                    }
                    if let land = configuration.iPadOverwrite?["land"]?.value() as? String {
                        configuration.land = land
                    }
                    if let itiname = configuration.iPadOverwrite?["itiname"]?.value() as? String {
                        configuration.itiname = itiname
                    }
                    if let homename = configuration.iPadOverwrite?["homename"]?.value() as? String {
                        configuration.homename = homename
                    }
                    if let itimnc = configuration.iPadOverwrite?["itimnc"]?.value() as? String {
                        configuration.itimnc = itimnc
                    }
                    if let nrfemto = configuration.iPadOverwrite?["nrfemto"]?.value() as? Bool {
                        configuration.nrfemto = nrfemto
                    }
                    if let out2G = configuration.iPadOverwrite?["out2G"]?.value() as? Bool {
                        configuration.out2G = out2G
                    }
                    if let setupDone = configuration.iPadOverwrite?["setupDone"]?.value() as? Bool {
                        configuration.setupDone = setupDone
                    }
                    if let minimalSetup = configuration.iPadOverwrite?["minimalSetup"]?.value() as? Bool {
                        configuration.minimalSetup = minimalSetup
                    }
                    if let disableFMobileCore = configuration.iPadOverwrite?["disableFMobileCore"]?.value() as? Bool {
                        configuration.disableFMobileCore = disableFMobileCore
                    }
                    if let countriesData = configuration.iPadOverwrite?["countriesData"]?.value() as? [String] {
                        configuration.countriesData = countriesData
                    }
                    if let countriesVoice = configuration.iPadOverwrite?["countriesVoice"]?.value() as? [String] {
                        configuration.countriesVoice = countriesVoice
                    }
                    if let countriesVData = configuration.iPadOverwrite?["countriesVData"]?.value() as? [String] {
                        configuration.countriesVData = countriesVData
                    }
                    if let carrierServices = configuration.iPadOverwrite?["carrierServices"]?.value() as? [[String]] {
                        configuration.carrierServices = carrierServices
                    }
                    if let roamLTE = configuration.iPadOverwrite?["roamLTE"]?.value() as? Bool {
                        configuration.roamLTE = roamLTE
                    }
                    if let roam5G = configuration.iPadOverwrite?["roam5G"]?.value() as? Bool {
                        configuration.roam5G = roam5G
                    }
                }
                
                completionHandler(configuration)
                return
            }
            
            completionHandler(nil)
        }
    }
    
    /// - Attention: This function should stay internal. It transforms the non-standard EU and UE 2-digit ISO codes to their actual values. This function is not supposed to be called separetly.
    /// This function reads the included destinations and converts the non-standard EU and UE 2-digit ISO codes to their actual values. The actual values behind the EU and UE ISO codes are set by the FMobile Team and may vary. You should not use that function for other purposes, as it is not standardized and only fits the current version of the API service. For instance, both of these ISO codes lack the inclusion of Great Britain, despite containing some other countries not inside the European Union. In short, don't use it, it is reserved for the staff that knows how they selected the corresponding country ISO code values.
    internal func europeanCheck() {
        
        let europe = CarrierIdentification.europe
        let europeland = CarrierIdentification.europeland
        
        let country = land ?? String()
        
        var countriesVData = self.countriesVData ?? [String]()
        var countriesData = self.countriesData ?? [String]()
        var countriesVoice = self.countriesVoice ?? [String]()
        
            
        if europe.contains(country) && !countriesVData.contains("EU") {
            countriesVData.append("EU")
        }
        
        if countriesData.contains("EU") {
            countriesData.append(contentsOf: europe)
        }
        
        if countriesData.contains("UE") {
            countriesData.append(contentsOf: europeland)
        }
        
        if countriesVoice.contains("EU") {
            countriesVoice.append(contentsOf: europe)
        }
        
        if countriesVoice.contains("UE") {
            countriesVoice.append(contentsOf: europeland)
        }
        
        if countriesVData.contains("EU") {
            countriesVData.append(contentsOf: europe)
        }
        
        if countriesVData.contains("UE") {
            countriesVData.append(contentsOf: europeland)
        }
        
        self.countriesData = countriesData
        self.countriesVData = countriesVData
        self.countriesVoice = countriesVoice
        
    }
    
    
    /// - Attention: This function should stay internal. It transforms the API radio technology strings to the actual CoreTelephony constants. This function is not supposed to be called separetly.
    internal static let replace: (String, (String) -> (), String) -> () = { input, output, def in
        
        if #available(iOS 14.1, *) {
            if input == "NR" {
                output(CTRadioAccessTechnologyNR)
                return
            } else if input == "NRNSA" {
                output(CTRadioAccessTechnologyNRNSA)
                return
            }
        }
        switch input {
            case "LTE":
                output(CTRadioAccessTechnologyLTE)
            case "WCDMA":
                output(CTRadioAccessTechnologyWCDMA)
            case "HSDPA":
                output(CTRadioAccessTechnologyHSDPA)
            case "EDGE":
                output(CTRadioAccessTechnologyEdge)
            case "GPRS":
                output(CTRadioAccessTechnologyGPRS)
            case "EHRPD":
                output(CTRadioAccessTechnologyeHRPD)
            case "HRPD":
                output(CTRadioAccessTechnologyeHRPD)
            case "HSUPA":
                output(CTRadioAccessTechnologyHSUPA)
            case "CDMA1X":
                output(CTRadioAccessTechnologyCDMA1x)
            case "CDMA":
                output(CTRadioAccessTechnologyCDMA1x)
            case "CDMAEVDOREV0":
                output(CTRadioAccessTechnologyCDMAEVDORev0)
            case "EVDO":
                output(CTRadioAccessTechnologyCDMAEVDORev0)
            case "CDMAEVDOREVA":
                output(CTRadioAccessTechnologyCDMAEVDORevA)
            case "EVDOA":
                output(CTRadioAccessTechnologyCDMAEVDORevA)
            case "CDMAEVDOREVB":
                output(CTRadioAccessTechnologyCDMAEVDORevB)
            case "EVDOB":
                output(CTRadioAccessTechnologyCDMAEVDORevB)
            default:
                output(def)
        }
    }
    
}
