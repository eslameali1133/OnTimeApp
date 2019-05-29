//
//  View+Ex.swift
//  Taqseem
//
//  Created by apple on 2/17/19.
//  Copyright © 2019 OnTime. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    
    // OUTPUT 1
    func dropShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
    
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 3
          self.layer.shadowOpacity = 0.5
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
