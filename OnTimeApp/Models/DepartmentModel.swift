//
//  DepartmentModel.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 7/3/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import Foundation
import UIKit
class DepartmentModelClass: NSObject {
    var _id = ""
    var _name = ""
    var _photo = ""
    var _descr = ""
    init(id:String , name : String , photo : String , descr : String ) {
        self._id = id
        self._name = name
        self._photo = photo
        self._descr = descr
    }
}
