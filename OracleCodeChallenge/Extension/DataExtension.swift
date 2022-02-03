//
//  DataExtension.swift
//  OracleCodeChallenge
//
//  Created by pradeep kumar jalakam on 2/3/22.
//

import Foundation

//extension to decode HTML Data
extension Data {
    var htmlToAttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var htmlToString: String { htmlToAttributedString?.string ?? "" }
}
