//
//  BadgesModel.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 8/19/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import Foundation
import UIKit
class BadgesModelClass: NSObject {
    
    var _id = ""
    var _title = ""
    var _img = ""
    init(id : String , title : String , img : String) {
        
        self._id = id
        self._title = title
        self._img = img
    }
}
