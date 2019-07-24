//
//  HomeRequestModel.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 7/4/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import Foundation
import UIKit
class HomeRequestModelClass: NSObject {
    
    var _id = ""
    var _request_name = ""
    var _request_descr = ""
    var _img = ""
    var _status = ""
    var _status_descr = ""
    var _icon = ""
    var _percentage = ""
    var _componants_ready = ""
    var _create_time = ""
    var _end_time = ""
    var _has_contract = ""
    var _has_price = ""
    var _new_message = ""
    var _start_time = ""
    var _stop_time = ""
    init(id : String , request_name : String , request_descr : String , img : String , status : String , status_descr : String , icon : String , percentage : String , componants_ready : String ,create_time : String , end_time : String , has_contract : String , has_price : String ,  new_message : String ,  start_time : String , stop_time : String) {
        
        self._id = id
        self._request_name = request_name
        self._request_descr = request_descr
        self._img = img
        self._status = status
        self._status_descr = status_descr
        self._icon = icon
        self._percentage = percentage
        self._componants_ready = componants_ready
        self._create_time = create_time
        self._end_time = end_time
        self._has_contract = has_contract
        self._has_price = has_price
        self._new_message = new_message
        self._start_time = start_time
        self._stop_time = stop_time
}
}
