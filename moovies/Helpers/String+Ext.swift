//
//  String+Ext.swift
//  moovies
//
//  Created by Sendo Tjiam on 28/03/22.
//

import Foundation

extension String {
    func getDateString(separator: Character) -> String {
        let splitString = self.split(separator: separator)
        var month = ""
        switch splitString[1] {
        case "01":
            month = "January"
        case "02":
            month = "February"
        case "03":
            month = "March"
        case "04":
            month = "April"
        case "05":
            month = "May"
        case "06":
            month = "June"
        case "07":
            month = "July"
        case "08":
            month = "August"
        case "09":
            month = "September"
        case "10":
            month = "October"
        case "11":
            month = "November"
        case "12":
            month = "December"
        default:
            month = ""
        }
        return "\(splitString[2]) \(month) \(splitString[0])"
    }
}
