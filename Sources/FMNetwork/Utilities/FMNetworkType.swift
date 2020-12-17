//
//  FMNetworkType.swift
//  FMobile
//
//  Created by PlugN on 01/07/2020.
//  Copyright © 2020 Groupe MINASTE. All rights reserved.
//

import Foundation

/**
    This property is used to set the type of SIM you want to retrieve. You need to specify it when you initialize your FMNetwork object.
 
    There are three options available :
        
        * sim
        * esim
        * current
 
    - Note: If you select .current as the type, the SIM card type returned in the FMNetwork property will very likely change to .sim or .esim accordingly. In case the card.type property still returns current on the FMNetwork object, it means FMNetwork couldn't identify the SIM card and the data returned are likely to be incorrect. Make sure you check the card.active property on the FMNetwork object first, to make sure the SIM card is in use and therefore identified.
*/
public enum FMNetworkType {
    case sim, esim, current
}

// DEPRECATED SECTION --------------------------------------


// OBSOLETED SECTION ---------------------------------------


// INTERNAL SECTION ----------------------------------------
