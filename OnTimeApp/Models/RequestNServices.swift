//
//  RequestNServices.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 7/8/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import Foundation
import UIKit
class RequestNServicesModelClass: NSObject {
    
    var _id = ""
    var _name = ""
    var _img = ""
    var _has_price = ""
    var _price = ""
    var _has_contract = ""
    var _has_time = ""
    var _average_time = ""
    var _tax_percentage = ""
    var _addons = [AddonsModelClass]()
    
    init(
        id : String ,
    name : String ,
    img : String ,
    has_price : String ,
    price : String ,
    has_contract : String ,
    has_time : String ,
    average_time : String ,
        tax_percentage : String ,
        addons : [AddonsModelClass]) {
        
        self._id = id
        self._name = name
        self._img = img
        self._has_price = has_price
        self._price = price
        self._has_contract = has_contract
        self._has_time = has_time
        self._average_time = average_time
        self._tax_percentage = tax_percentage
        self._addons = addons
    }
}
