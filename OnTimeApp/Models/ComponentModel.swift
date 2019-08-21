//
//  ComponentModel.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 8/20/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import Foundation
import UIKit
class ComponentModelClass: NSObject {
    
    var _component_name = ""
    var _price = ""
    var _duration = ""
    
    init(component_name : String , price : String , duration : String) {
        self._component_name = component_name
        self._price = price
        self._duration = duration
    }
}
