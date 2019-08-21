//
//  FireBaseNotModel.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 8/21/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import Foundation
import UIKit
class FirBasNotModelClass: NSObject {
    var message = ""
    var notification_id = ""
    var request_id = ""
    var token = ""
    var type = ""
    
    init(message : String , notification_id : String , request_id : String , token : String , type : String ) {
        self.message = message
        self.notification_id = notification_id
        self.request_id = request_id
        self.token = token
        self.type = type
    }
}
