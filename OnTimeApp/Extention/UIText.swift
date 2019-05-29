//
//  UIText.swift
//  CarWash
//
//  Created by Mohammad Farhan on 22/12/179/28/17.
//  Copyright © 2017 Mohammad Farhan. All rights reserved.
//

import Foundation
import UIKit

extension Dictionary where Value: Equatable {
    func allKeys(forValue val: Value) -> [Key] {
        return self.filter { $1 == val }.map { $0.0 }
    }
}


extension UILabel {

    func translation(key:String){
        self.text = AppCommon.sharedInstance.localization(key)
    }


}

extension UITextField {

    func translation(key:String){
        self.text = AppCommon.sharedInstance.localization(key)
    }

    func translationPlaceholder(key:String){
        self.placeholder = AppCommon.sharedInstance.localization(key)
    }


}

extension UINavigationItem {
    func translation(key:String){
        self.title = AppCommon.sharedInstance.localization(key)
    }

}

extension UIButton {
    func translation(key:String){
        self.setTitle(AppCommon.sharedInstance.localization(key), for: .normal)
    }
}


extension UISegmentedControl {
    func translation(key:String, segmentIndex: Int){
        self.setTitle(AppCommon.sharedInstance.localization(key), forSegmentAt: segmentIndex)
    }
}


