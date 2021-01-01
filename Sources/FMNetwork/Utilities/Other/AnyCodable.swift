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
//  AnyCodable.swift
//  FMobile
//
//  Created by PlugN on 25/01/2020.
//  Copyright © 2020 Groupe MINASTE. All rights reserved.
//

import Foundation

/// This internal class is used to decode and encode the data provided by the FMobile API service.
public struct AnyCodable: Codable {
    
    /// Int data sample
    private var int: Int?
    
    /// String data sample
    private var string: String?
    
    /// Bool data sample
    private var bool: Bool?
    
    /// Double data sample
    private var double: Double?
    
    /// Initialize an Int
    /// - Parameter int: An Int
    internal init(_ int: Int) {
        self.int = int
    }

    /// Initialize a String
    /// - Parameter string: A String
    internal init(_ string: String) {
        self.string = string
    }

    /// Initialize a Bool
    /// - Parameter bool: A Bool
    internal init(_ bool: Bool) {
        self.bool = bool
    }

    /// Initialize a Double
    /// - Parameter int: A Double
    internal init(_ double: Double) {
        self.double = double
    }
    
    /// Initialize from deocder, decode to all supported types
    /// - Parameter decoder: the handling decoder
    /// - Throws: Throws if the value couldn't be properly decoded
    public init(from decoder: Decoder) throws {
        if let int = try? decoder.singleValueContainer().decode(Int.self) {
            self.int = int
            return
        }

        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self.string = string
            return
        }

        if let bool = try? decoder.singleValueContainer().decode(Bool.self) {
            self.bool = bool
            return
        }

        if let double = try? decoder.singleValueContainer().decode(Double.self) {
            self.double = double
        }
    }

    
    /// Encode to a given handling encoder
    /// - Parameter encoder: the handling encoder
    /// - Throws: Throws if the variable couldn't be properly encoded
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        if let anyValue = self.value() {
            if let value = anyValue as? Int {
                try container.encode(value)
                return
            }

            if let value = anyValue as? String {
                try container.encode(value)
                return
            }

            if let value = anyValue as? Bool {
                try container.encode(value)
                return
            }

            if let value = anyValue as? Double {
                try container.encode(value)
                return
            }
        }

        try container.encodeNil()
    }

    
    /// Get the correct value in the detected type
    /// - Returns: The value in the correct type
    internal func value() -> Any? {
        return self.int ?? self.string ?? self.bool ?? self.double
    }
}
