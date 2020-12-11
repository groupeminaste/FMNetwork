//
//  FMNetworkData.swift
//  FMobile
//
//  Created by PlugN on 01/07/2020.
//  Copyright © 2020 Groupe MINASTE. All rights reserved.
//

import Foundation
import CoreTelephony

public class FMNetworkSIMData {
    
    public var mcc: String
    public var mnc: String
    public var land: String
    public var name: String
    public var fullname: String
    public var active: Bool
    public var type: FMNetworkType

    internal var simname: String
    internal var data: String
    internal var carrier: CTCarrier
    
    internal init(mcc: String = String(), mnc: String = String(), land: String = String(), name: String = String(), fullname: String = String(), data: String = String(), simname: String = String(), carrier: CTCarrier = CTCarrier(), active: Bool = false,  eligibleminimalsetup: Bool = false, type: FMNetworkType = .sim) {
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
    }
    
}
