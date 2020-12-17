//
//  FMNetwork.swift
//  FMobile
//
//  Created by PlugN on 01/07/2020.
//  Copyright © 2020 Groupe MINASTE. All rights reserved.
//

import Foundation
import CoreTelephony

/// This class contains every data about a SIM card and its connected network.
/// - Note: Make sure you verify that card.active is equal to true before processing any data returned by the FMNetwork object.
public class FMNetwork {
    
    /// This property contains every data about a SIM card.
    /// - Note: Make sure you verify that card.active is equal to true before processing any data returned by the FMNetwork object.
    public var card: FMNetworkSIMData
    
    /// This property contains every data about a connected network.
    /// - Note: Make sure you verify that card.active is equal to true before processing any data returned by the FMNetwork object.
    public var network: FMNetworkData
    
    /// Initialize an FMNetwork object. Retrieves all the data for a given SIM card type.
    /// - Parameter type: SIM card type.<br><br>
    /// There are three options available :
    ///   * .sim
    ///   * .esim
    ///   * .current
    ///
    /// - Note: If you select .current as the type, the SIM card type returned in the FMNetwork property will very likely change to .sim or .esim accordingly. In case the card.type property still returns current on the FMNetwork object, it means FMNetwork couldn't identify the SIM card and the data returned are likely to be incorrect. Make sure you check the card.active property on the FMNetwork object first, to make sure the SIM card is in use and therefore identified.
    public init(type: FMNetworkType) {
        (card, network) = FMNetwork.createFMNetwork(type)
    }
    
    
    
    // DEPRECATED SECTION --------------------------------------
    
    
    // OBSOLETED SECTION ---------------------------------------
    
    
    // INTERNAL SECTION ----------------------------------------
    
    
    /// Internal function to construct an FMNetwork object, with a given SIM card type.
    /// - Parameter type: SIM card type (.sim, .esim or .current)
    /// - Returns: A couple of FMNetworkSIMData and FMNetworkData to be inserted in the respective FMNetwork class variables
    internal static func createFMNetwork(_ type: FMNetworkType) -> (FMNetworkSIMData, FMNetworkData) {
        var type = type
        
        var card: FMNetworkSIMData
        var network: FMNetworkData
        
        var operatorPListSymLinkPath: String
        var carrierPListSymLinkPath: String
        var targetSIM: String
        
        if type == .current {
            
            operatorPListSymLinkPath = "/var/mobile/Library/Preferences/com.apple.operator.plist"
            carrierPListSymLinkPath = "/var/mobile/Library/Preferences/com.apple.carrier.plist"
            
            if #available(iOS 12.0, *) {
                
                let operatorPListSymLinkPath_1 = "/var/mobile/Library/Preferences/com.apple.operator_1.plist"
                let carrierPListSymLinkPath_1 = "/var/mobile/Library/Preferences/com.apple.carrier_1.plist"
                
                let operatorPListSymLinkPath_2 = "/var/mobile/Library/Preferences/com.apple.operator_2.plist"
                let carrierPListSymLinkPath_2 = "/var/mobile/Library/Preferences/com.apple.carrier_2.plist"
                
                let fileManager = FileManager.default
                let operatorPListPath = try? fileManager.destinationOfSymbolicLink(atPath: operatorPListSymLinkPath)
                let carrierPListPath = try? fileManager.destinationOfSymbolicLink(atPath: carrierPListSymLinkPath)
                
                let operatorPListPath_1 = try? fileManager.destinationOfSymbolicLink(atPath: operatorPListSymLinkPath_1)
                let carrierPListPath_1 = try? fileManager.destinationOfSymbolicLink(atPath: carrierPListSymLinkPath_1)
                
                let operatorPListPath_2 = try? fileManager.destinationOfSymbolicLink(atPath: operatorPListSymLinkPath_2)
                let carrierPListPath_2 = try? fileManager.destinationOfSymbolicLink(atPath: carrierPListSymLinkPath_2)
                
                if operatorPListPath == operatorPListPath_2 && carrierPListPath == carrierPListPath_2 {
                    type = .esim
                } else if operatorPListPath == operatorPListPath_1 && carrierPListPath == carrierPListPath_1 {
                    type = .sim
                } else {
                    type = .current
                }
            } else {
                type = .sim
            }
            
        }
        
        card = FMNetworkSIMData(type: type)
        network = FMNetworkData()
        
        if type == .sim || type == .current {
            
            if type == .current {
                operatorPListSymLinkPath = "/var/mobile/Library/Preferences/com.apple.operator.plist"
                carrierPListSymLinkPath = "/var/mobile/Library/Preferences/com.apple.carrier.plist"
            } else {
                if #available(iOS 12.0, *) {
                    operatorPListSymLinkPath = "/var/mobile/Library/Preferences/com.apple.operator_1.plist"
                    carrierPListSymLinkPath = "/var/mobile/Library/Preferences/com.apple.carrier_1.plist"
                } else {
                    operatorPListSymLinkPath = "/var/mobile/Library/Preferences/com.apple.operator.plist"
                    carrierPListSymLinkPath = "/var/mobile/Library/Preferences/com.apple.carrier.plist"
                }
            }
            targetSIM = "0000000100000001"
            
        } else {
            operatorPListSymLinkPath = "/var/mobile/Library/Preferences/com.apple.operator_2.plist"
            carrierPListSymLinkPath = "/var/mobile/Library/Preferences/com.apple.carrier_2.plist"
            targetSIM = "0000000100000002"
            
        }
        
        // Déclaration du gestionaire de fichiers
        let fileManager = FileManager.default
        let operatorPListPath = try? fileManager.destinationOfSymbolicLink(atPath: operatorPListSymLinkPath)
        
        // Obtenir le fichier de configuration de la carte SIM
        let carrierPListPath = try? fileManager.destinationOfSymbolicLink(atPath: carrierPListSymLinkPath)
        
        card.data = "-----"
        if !(carrierPListPath ?? "unknown").lowercased().contains("unknown") {
            let values = carrierPListPath?.groups(for: "[0-9]+")
            if let group = values?.first {
                card.data = group[0]
            }
        }
        
        network.data = "-----"
        if !(operatorPListPath ?? "unknown").lowercased().contains("unknown"){
            let values = operatorPListPath?.groups(for: "[0-9]+")
            if let group = values?.first {
                network.data = group[0]
            }
        }
        
        network.name = "Carrier"
        network.fullname = "Carrier"
        
        let url = URL(fileURLWithPath: operatorPListPath ?? "Error")
        do {
            let test: NSDictionary
            if #available(iOS 11.0, *) {
                test = try NSDictionary(contentsOf: url, error: ())
            } else {
                // Fallback on earlier versions
                test = NSDictionary(contentsOf: url) ?? NSDictionary()
            }
            let array = test["StatusBarImages"] as? NSArray ?? NSArray.init(array: [0])
            let secondDict = NSDictionary(dictionary: array[0] as? Dictionary ?? NSDictionary() as? Dictionary<AnyHashable, Any> ?? Dictionary())
            
            network.name = (secondDict["StatusBarCarrierName"] as? String) ?? "Carrier"
            network.fullname = (secondDict["CarrierName"] as? String) ?? "Carrier"
        } catch {}
        
        
        card.simname = "Carrier"
        card.fullname = "Carrier"
        let urlcarrier = URL(fileURLWithPath: carrierPListPath ?? "Error")
        do {
            let testsim: NSDictionary
            if #available(iOS 11.0, *) {
                testsim = try NSDictionary(contentsOf: urlcarrier, error: ())
            } else {
                // Fallback on earlier versions
                testsim = NSDictionary(contentsOf: urlcarrier) ?? NSDictionary()
            }
            let arraysim = testsim["StatusBarImages"] as? NSArray ?? NSArray.init(array: [0])
            let secondDictsim = NSDictionary(dictionary: arraysim[0] as? Dictionary ?? NSDictionary() as? Dictionary<AnyHashable, Any> ?? Dictionary())
                    
            card.simname = (secondDictsim["StatusBarCarrierName"] as? String) ?? "Carrier"
            card.fullname = (secondDictsim["CarrierName"] as? String) ?? "Carrier"
        } catch {}
        
        network.mcc = String(network.data.prefix(3))
        network.mnc = String(network.data.count == 6 ? network.data.suffix(3) : network.data.suffix(2))
        
        let checkmcc = String(card.data.prefix(3))
        let checkmnc = String(card.data.count == 6 ? card.data.suffix(3) : card.data.suffix(2))
        
        if (card.mcc != checkmcc || card.mnc != checkmnc) && (card.data != "-----") {
            card.mcc = checkmcc
            card.mnc = checkmnc
        }
        
        let info = CTTelephonyNetworkInfo()
        
        if #available(iOS 12.0, *) {
        for (service, carrier) in info.serviceSubscriberCellularProviders ?? [:] {
            if service == targetSIM {
                let radio = info.serviceCurrentRadioAccessTechnology?[service] ?? ""
                card.carrier = carrier
                network.connected = radio
                if let mobileCountryCode = card.carrier.mobileCountryCode, let mobileNetworkCode = card.carrier.mobileNetworkCode {
                    if card.mcc != mobileCountryCode || card.mnc != mobileNetworkCode {
                        card.mcc = mobileCountryCode
                        card.mnc = mobileNetworkCode
                    }
                    card.active = true
                }
            }
        }
        } else {
            if type == .sim {
                card.active = true
            }
            card.carrier = info.subscriberCellularProvider ?? CTCarrier()
            network.connected = info.currentRadioAccessTechnology ?? ""
        }
        
        card.name = card.carrier.carrierName ?? "Carrier"
        
        if card.name == "Carrier" && card.fullname != "Carrier" {
            card.name = card.fullname
        }
        
        if card.name == "Carrier" && card.simname != "Carrier" {
            card.name = card.simname
        }
        
        if network.name == "Carrier" && network.fullname != "Carrier" {
            network.name = network.fullname
        }

        if (network.mcc == "---" && network.mnc == "--"){
            network.mcc = card.carrier.mobileCountryCode ?? "---"
            network.mnc = card.carrier.mobileNetworkCode ?? "--"
        }
        
        card.land = CarrierIdentification.getIsoCountryCode(card.mcc, card.mnc)
        network.land = CarrierIdentification.getIsoCountryCode(network.mcc, network.mnc)
        
        return (card, network)
    }
    
}
