//
//  StringExtension.swift
//  OracleCodeChallenge
//
//  Created by pradeep kumar jalakam on 2/3/22.
//

import Foundation
import Darwin

//extension to decode HTML String
extension StringProtocol {
    var htmlToAttributedString: NSAttributedString? {
        Data(utf8).htmlToAttributedString
    }
    var htmlToString: String {
        htmlToAttributedString?.string ?? ""
    }
    
}


// this Extension helps to onvert UNIX time into Date String
extension Int {
    var localDateString: String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }
    // rounds the string into k for thousands and M for millions
    var roundedWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(round(million*10)/10)M"
        }
        else if thousand >= 1.0 {
            return "\(round(thousand*10)/10)K"
        }
        else {
            return "\(self)"
        }
    }
}
