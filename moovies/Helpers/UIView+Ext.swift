//
//  UIView+Ext.swift
//  moovies
//
//  Created by Sendo Tjiam on 22/03/22.
//

import UIKit

extension UIView {
    func dropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.25
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowRadius = 4
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    func roundedCorner(width: CGFloat = 0.05, color : CGColor = UIColor.black.cgColor, radius : CGFloat = 6) {
        self.layer.borderWidth = width
        self.layer.borderColor = color
        self.layer.cornerRadius = radius
    }
}
