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
import XCTest
import CoreTelephony

@testable import FMNetwork

final class FMNetworkTests: XCTestCase {
    func completeTest() {
        
        // Complete test of the expected values on an iPhone 11 using a Free Mobile SIM card and Transatel eSIM card, in regular office usage.
        
        let current = FMNetwork(type: .current)
        let sim = FMNetwork(type: .sim)
        let esim = FMNetwork(type: .esim)
        
        if let network = current.device.currentWifiNetwork {
            print("The device is connected to the " + network.ssid + " network.")
        } else {
            print("The device is not connected to Wi-Fi, or the app does not meet the requirements.")
        }
        
        current.loadFMobileService() { (param) in
            print(param)
        }
        
        sim.loadFMobileService() { (param) in
            print(param)
        }
        
        esim.loadFMobileService() { (param) in
            print(param)
        }
        
        // CURRENT CARD TEST
            // CARD TEST
            XCTAssertEqual(current.card.active, true)
            XCTAssertEqual(current.card.type, .sim)
            XCTAssertEqual(current.card.name, "Free")
            XCTAssertEqual(current.card.mcc, "208")
            XCTAssertEqual(current.card.mnc, "15")
            XCTAssertEqual(current.card.land, "FR")
            // NETWORK TEST
            XCTAssertEqual(current.network.name, "Free")
            XCTAssertEqual(current.network.mcc, "208")
            XCTAssertEqual(current.network.mnc, "15")
            XCTAssertEqual(current.network.land, "FR")
            XCTAssertEqual(current.network.connected, CTRadioAccessTechnologyLTE)
            // INTERNAL TEST
            XCTAssertEqual(current.card.carrier.mobileCountryCode, "208")
            XCTAssertEqual(current.card.carrier.mobileNetworkCode, "15")
            XCTAssertEqual(current.card.carrier.allowsVOIP, true)
            XCTAssertEqual(current.card.carrier.isoCountryCode, "FR")
            XCTAssertEqual(current.card.fullname, "Free")
            XCTAssertEqual(current.card.simname, "Free")
            XCTAssertEqual(current.card.data, "20815")
            XCTAssertEqual(current.network.fullname, "Free")
            XCTAssertEqual(current.network.data, "20815")
        // SIM CARD TEST
            // CARD TEST
            XCTAssertEqual(sim.card.active, true)
            XCTAssertEqual(sim.card.type, .sim)
            XCTAssertEqual(sim.card.name, "Free")
            XCTAssertEqual(sim.card.mcc, "208")
            XCTAssertEqual(sim.card.mnc, "15")
            XCTAssertEqual(sim.card.land, "FR")
            // NETWORK TEST
            XCTAssertEqual(sim.network.name, "Free")
            XCTAssertEqual(sim.network.mcc, "208")
            XCTAssertEqual(sim.network.mnc, "15")
            XCTAssertEqual(sim.network.land, "FR")
            XCTAssertEqual(sim.network.connected, CTRadioAccessTechnologyLTE)
            // INTERNAL TEST
            XCTAssertEqual(sim.card.carrier.mobileCountryCode, "208")
            XCTAssertEqual(sim.card.carrier.mobileNetworkCode, "15")
            XCTAssertEqual(sim.card.carrier.allowsVOIP, true)
            XCTAssertEqual(sim.card.carrier.isoCountryCode, "FR")
            XCTAssertEqual(sim.card.fullname, "Free")
            XCTAssertEqual(sim.card.simname, "Free")
            XCTAssertEqual(sim.card.data, "20815")
            XCTAssertEqual(sim.network.fullname, "Free")
            XCTAssertEqual(sim.network.data, "20815")
        // ESIM CARD TEST
            // CARD TEST
            XCTAssertEqual(esim.card.active, true)
            XCTAssertEqual(esim.card.type, .esim)
            XCTAssertEqual(esim.card.name, "Transatel")
            XCTAssertEqual(esim.card.mcc, "901")
            XCTAssertEqual(esim.card.mnc, "37")
            XCTAssertEqual(esim.card.land, "WD")
            // NETWORK TEST
            XCTAssertEqual(esim.network.name, "Orange F")
            XCTAssertEqual(esim.network.mcc, "208")
            XCTAssertEqual(esim.network.mnc, "01")
            XCTAssertEqual(esim.network.land, "FR")
            XCTAssertEqual(esim.network.connected, CTRadioAccessTechnologyLTE)
            // INTERNAL TEST
            XCTAssertEqual(esim.card.carrier.mobileCountryCode, "901")
            XCTAssertEqual(esim.card.carrier.mobileNetworkCode, "37")
            XCTAssertEqual(esim.card.carrier.allowsVOIP, true)
            XCTAssertEqual(esim.card.carrier.isoCountryCode, "")
            XCTAssertEqual(esim.card.fullname, "Carrier")
            XCTAssertEqual(esim.card.simname, "Carrier")
            XCTAssertEqual(esim.card.data, "90137")
            XCTAssertEqual(esim.network.fullname, "OrangeF")
            XCTAssertEqual(esim.network.data, "20801")
    }

    static var allTests = [
        ("completeTest", completeTest),
    ]
}
