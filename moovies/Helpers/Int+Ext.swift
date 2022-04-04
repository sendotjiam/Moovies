//
//  Int+Ext.swift
//  moovies
//
//  Created by Sendo Tjiam on 04/04/22.
//

import Foundation

extension Int {
    func formatPriceNumber(separator: String = ".", currency: String = "USD") -> String {
        var copyNumber = self
        var result: [String] = []
        while copyNumber > 0 {
            let lastNumber = copyNumber % 1000
            copyNumber = copyNumber / 1000
            
            if lastNumber == 0 {
                result.insert("000", at: 0)
            } else if lastNumber < 10 && copyNumber > 0 {
                result.insert("00\(lastNumber)", at: 0)
            } else if lastNumber < 100 && copyNumber > 0 {
                result.insert("0\(lastNumber)", at: 0)
            } else {
                result.insert("\(lastNumber)", at: 0)
            }
            
            if copyNumber > 0 {
                result.insert(separator, at: 0)
            }
        }
        return "Cost around \(result.joined()) \(currency) "
    }
}
