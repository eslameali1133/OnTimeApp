//
//  ContractModel.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 8/18/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import Foundation
import UIKit
class ContractModelClass: NSObject {
    
    var _name = ""
    var _pdf = ""
    init(name : String , pdf : String) {
        
        self._name = name
        self._pdf = pdf
    }
}
