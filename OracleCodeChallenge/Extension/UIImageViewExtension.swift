//
//  UIImageViewExtension.swift
//  OracleCodeChallenge
//
//  Created by pradeep kumar jalakam on 2/2/22.
//

import Foundation
import UIKit

@IBDesignable extension UIImageView {

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
}
