//
//  RequestDetailModel.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 7/29/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import Foundation
import UIKit
class RequestDetailModelClass: NSObject {
    var _request_name = ""
    var _request_descr = ""
    var _start_time = ""
    var _end_time = ""
    var _service_name = ""
    var _start_from = ""
    var _total_time = ""
    var _terms = ""
    var _addons = [AddonsModelClass]()
    var _contracts = [ContractModelClass]()
    var _Attachment = [AttachmentModelClass]()
    var _components = [ComponentModelClass]()
    init(
        request_name : String ,
        request_descr : String ,
        start_time : String ,
        end_time : String ,
        service_name : String ,
        start_from : String ,
        total_time : String ,
        terms : String ,
        addons : [AddonsModelClass],
        Contracts : [ContractModelClass] ,
        Attachment : [AttachmentModelClass],
        components : [ComponentModelClass]) {
        
        self._request_name = request_name
        self._request_descr = request_descr
        self._start_time = start_time
        self._end_time = end_time
        self._service_name = service_name
        self._start_from = start_from
        self._total_time = total_time
        self._terms = terms
        self._addons = addons
        self._contracts = Contracts
        self._Attachment = Attachment
        self._components = components
    }
}
