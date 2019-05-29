//
//  UITextField.swift
//  Khadimah
//
//  Created by Mohammad Farhan on 22/12/1711/14/17.
//  Copyright © 2017 Mohammad Farhan Farhan. All rights reserved.
//

import Foundation
import UIKit

extension UITextField{
    
    
    func labelMessage()->UILabel{
        
        //        self.layer.borderColor = UIColor.red.cgColor
        //        self.layer.borderWidth = 1
        self.textColor = UIColor.hexColor(string: "c42727")
        
        let messageLabel  = UILabel(frame: CGRect(x:  self.frame.origin.x, y: self.frame.origin.y+self.frame.size.height, width: self.frame.size.width, height: 20))
        messageLabel.text = "rest"
        messageLabel.textColor = UIColor.red
        messageLabel.tag = -self.tag
        messageLabel.font = UIFont.systemFont(ofSize: 10)
        //  self.leftView?.tintColor = Color.errorColor
        self.superview?.addSubview(messageLabel)
        return messageLabel
}
}
