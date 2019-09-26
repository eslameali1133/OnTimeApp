//
//  MessagesModel.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 9/15/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import Foundation
import UIKit
class MessageModelClass: NSObject {
    
    var _id = ""
    var _msg_text = ""
    var _file_type = ""
    var _file_url = ""
    var _time = ""
    var _msg_type = ""
    var _readed = ""
    
    init(id : String , msg_text : String , file_type : String , file_url : String ,
        time : String,
        msg_type : String ,
        readed : String  ) {

        self._id = id
        self._msg_text = msg_text
        self._file_url = file_url
        self._file_type = file_type
        self._time = time
        self._msg_type = msg_type
        self._readed = readed
    }
}
