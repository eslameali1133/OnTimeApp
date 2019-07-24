//
//  ServicesModel.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 7/8/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import Foundation
import UIKit
class ServicesModelClass: NSObject {
    
    var _id = ""
    var _name = ""
    var _img = ""
    
    init(id : String , name : String , img : String) {
        
        self._id = id
        self._name = name
        self._img = img
    }
}
