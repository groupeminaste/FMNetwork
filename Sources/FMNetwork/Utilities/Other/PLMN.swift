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
//  PLMN.swift
//  FMNetwork
//
//  Created by PlugN on 21/12/2020.
//  Copyright © 2020 Groupe MINASTE. All rights reserved.
//

import Foundation

/// This class contains data about a declared PLMN roaming network.
public class PLMN {
    
    /** This propery returns the Mobile Country Code (MCC) of the PLMN, as a String.
    ```text
    Example:
    mcc == "208" (The MCC for France)
    ```
     
    - Warning: This variable has no default value.
    */
    public var mcc: String
    
    /** This propery returns the Mobile Network Code (MNC) of the PLMN, as a String.
    ```text
    Example:
    mnc == "01" (The MNC for Orange France)
    ```
     
    - Warning: This variable has no default value.
    */
    public var mnc: String
    
    
    /// Initialize a PLMN object
    /// - Parameters:
    ///   - mcc: The Mobile Country Code (MCC) of the PLMN
    ///   - mnc: The Mobile Network Code (MNC) of the PLMN
    public init(mcc: String, mnc: String) {
        self.mcc = mcc
        self.mnc = mnc
    }
}
