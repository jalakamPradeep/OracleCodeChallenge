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

extension UIImageView {
    // this extension is used to lazyload the image from url
    func lazyLoadImage(link:URL, contentMode: UIView.ContentMode) {
        URLSession.shared.dataTask( with: link, completionHandler: {
            (data, response, error) -> Void in
            
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}
