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
