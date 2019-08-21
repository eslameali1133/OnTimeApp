//
//  AttachmentModel.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 8/19/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import Foundation
import UIKit
class AttachmentModelClass: NSObject {
    var _file = ""
    var _size = ""
    var _upload_date = ""
    init(file : String , size : String , upload_date : String) {
        self._file = file
        self._size = size
        self._upload_date = upload_date
    }
}
