//
//  SocketModel.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 9/23/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import Foundation
import UIKit
class SocketModelClass: NSObject {
    
    var _user_id = ""
    var _room_id = ""
    var _time = ""
    var _file_type = ""
    var _msg_type = ""
    var _msg_text = ""
    var _file_url = ""
    var _request_id = ""
    
    init(user_id : String ,
        room_id : String ,
        time : String ,
        file_type : String ,
        msg_type : String ,
        msg_text : String ,
        file_url : String ,
        request_id : String) {
        
        self._user_id = user_id
        self._room_id = room_id
        self._time = time
        self._file_type = file_type
        self._msg_type = msg_type
        self._msg_text = msg_text
        self._file_url = file_url
        self._request_id = request_id
    }
}
