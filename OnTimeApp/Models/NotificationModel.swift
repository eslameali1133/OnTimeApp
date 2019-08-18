//
//  NotificationModel.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 7/30/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import Foundation
import UIKit
class NotificationModelClass: NSObject {
    var _id = ""
    var _type = ""
    var _msg_header = ""
    var _msg_body = ""
    var _time = ""
    var _icon = ""
    var _request_id = ""
    var _read_status = ""
    init(id : String , type : String , msg_header : String , msg_body : String , time : String , icon : String , request_id : String , read_status : String ) {
        self._id = id
        self._type = type
        self._msg_header = msg_header
        self._msg_body = msg_body
        self._time = time
        self._icon = icon
        self._request_id = request_id
        self._read_status = read_status
    }
}
