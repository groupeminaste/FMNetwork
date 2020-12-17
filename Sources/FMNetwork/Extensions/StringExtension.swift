//
//  StringExtension.swift
//  FMobile
//
//  Created by Nathan FALLET on 15/05/2019.
//  Copyright © 2019 Groupe MINASTE. All rights reserved.
//

import Foundation

/// This internal extension is used to group String values
internal extension String {
    
    
    // DEPRECATED SECTION --------------------------------------
    
    
    // OBSOLETED SECTION ---------------------------------------
    
    
    // INTERNAL SECTION ----------------------------------------
    
    
    /// This function groups a String using a given Regex pattern
    /// - Parameter regexPattern: The Regex pattern to be used
    /// - Returns: The double array containing the groups splited by the Regex pattern
    func groups(for regexPattern: String) -> [[String]] {
        do {
            let text = self
            let regex = try NSRegularExpression(pattern: regexPattern)
            let matches = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
            return matches.map { match in
                return (0..<match.numberOfRanges).map {
                    let rangeBounds = match.range(at: $0)
                    guard let range = Range(rangeBounds, in: text) else {
                        return ""
                    }
                    return String(text[range])
                }
            }
        } catch {
            return []
        }
    }
    
}
