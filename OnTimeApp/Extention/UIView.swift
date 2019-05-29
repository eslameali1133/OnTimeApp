//
//  UIView.swift
//  CarWash
//
//  Created by Mohammad Farhan on 22/12/1710/11/17.
//  Copyright © 2017 CarWash. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore


import UIKit

extension UIView {
    
    /**
     Rounds the given set of corners to the specified radius
     
     - parameter corners: Corners to round
     - parameter radius:  Radius to round to
     */
    func round(corners: UIRectCorner, radius: CGFloat) {
        _ = _round(corners: corners, radius: radius)
//        self.translatesAutoresizingMaskIntoConstraints = false

    }
    
    /**
     Rounds the given set of corners to the specified radius with a border
     
     - parameter corners:     Corners to round
     - parameter radius:      Radius to round to
     - parameter borderColor: The border color
     - parameter borderWidth: The border width
     */
    func round(corners: UIRectCorner, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        let mask = _round(corners: corners, radius: radius)
        addBorder(mask: mask, borderColor: borderColor, borderWidth: borderWidth)
//        self.translatesAutoresizingMaskIntoConstraints = true
//        mask.masksToBounds = false

    }
    
    /**
     Fully rounds an autolayout view (e.g. one with no known frame) with the given diameter and border
     
     - parameter diameter:    The view's diameter
     - parameter borderColor: The border color
     - parameter borderWidth: The border width
     */
    func fullyRound(diameter: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = diameter / 2
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor;
//        self.translatesAutoresizingMaskIntoConstraints = true

    }
    
}

private extension UIView {
    
    @discardableResult func _round(corners: UIRectCorner, radius: CGFloat) -> CAShapeLayer {
//        self.translatesAutoresizingMaskIntoConstraints = true

        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        return mask
    }
    
    func addBorder(mask: CAShapeLayer, borderColor: UIColor, borderWidth: CGFloat) {
//        self.translatesAutoresizingMaskIntoConstraints = true

        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }
    
}



extension NSMutableAttributedString{
    func setColorForText(_ textToFind: String, with color: UIColor) {
        let range = self.mutableString.range(of: textToFind, options: .caseInsensitive)
        if range.location != NSNotFound {
            addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
    }
}


extension UIView{
    
    func AddBottomLine(_ Size:CGFloat , color:UIColor = UIColor.gray){
        
        let border = CALayer()
        
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.height-Size,width: UIScreen.main.bounds.size.width, height: Size)
        self.layer.addSublayer(border)
    }
    
    func AddTopLine(_ Size:CGFloat,color:UIColor){
        
        let border = CALayer()
        
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0,width: UIScreen.main.bounds.size.width, height: Size)
        self.layer.addSublayer(border)
    }
//
//    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
//        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        self.layer.mask = mask
//    }
    
    
    
    
}



extension UIView {
    private func addShadow(opacity: Float, radius: CGFloat, color: UIColor, offset: CGSize) {
        layer.masksToBounds = false
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
//
//    func addButtonShadow() {
//        addShadow(opacity: 1.0,
//                  radius: 8.0,
//                  color: UIColor.nocGreyishBlue46,
//                  offset: CGSize(width: 0, height: 6))
//    }
//
    
    func incidentSummaryCellShadow() {
        addShadow(opacity: 1.0,
                  radius: 4.0,
                  color: UIColor.nocWhite50,
                  offset: CGSize(width: 0, height: 2))
    }
    
    func sideViewShadow() {
        addShadow(opacity: 0.5,
                  radius: 4,
                  color: UIColor.black,
                  offset: CGSize(width: 2, height: 0))
    }
    
    func addIncidentDetailCellShadow() {
        addShadow(opacity: 0.5,
                  radius: 4,
                  color: UIColor.nocPinkishGrey,
                  offset: CGSize(width: 0, height: 2))
    }
    
    func statusCenterShadow() {
        addShadow(opacity: 0.2,
                  radius: 2.0,
                  color: UIColor.black,
                  offset: CGSize(width: -1, height: 1))
    }
    
    
    func addConnectButtonShadow() {
        addShadow(opacity: 1.0,
                  radius: 0.0,
                  color: UIColor.nocWaterBlue,
                  offset: CGSize(width: 0, height: 3.0))
    }
    
//    func addMenuButtonShadowWith(color: UIColor) {
//        addShadow(opacity: 1.0,
//                  radius: 0.0,
//                  color: color,
//                  offset: CGSize(width: 0, height: 3.0))
//    }
    
    func removeMenuButtonShadow() {
        layer.backgroundColor = UIColor.nocFiltersButtonsGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.clear.cgColor
    }
    
    func connectionTypeShadow() {
        addShadow(opacity: 0.5,
                  radius: 25.0,
                  color: UIColor(white: 0.88, alpha: 1.0),
                  offset: CGSize(width: 0, height: 2.0))
    }
    
    func volumesPeriodBoxShadow() {
        addShadow(opacity: 0.5,
                  radius: 14.0,
                  color: UIColor.lightGray,
                  offset: CGSize(width: 0, height: 4.0))
    }
    
    func navigationButtonsShadow() {
        addShadow(opacity: 5.0,
                  radius: 10,
                  color: UIColor.lightGray,
                  offset: CGSize(width: 0, height: 2.0))
    }
    
    func machineSideViewShadow() {
        addShadow(opacity: 0.2,
                  radius: 2.0,
                  color: UIColor(white: 0.38, alpha: 1.0),
                  offset: CGSize(width: 1.0, height: 0.0))
    }
    
    func storageCellShadow() {
        addShadow(opacity: 0.5,
                  radius: 3.0,
                  color: UIColor.nocWhite50,
                  offset: CGSize(width: 0, height: 1))
    }
}

