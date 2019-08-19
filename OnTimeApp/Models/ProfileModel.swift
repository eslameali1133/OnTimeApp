//
//  ProfileModel.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 8/19/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import Foundation
import UIKit
class ProfileModelClass: NSObject {

var _id = ""
var _name = ""
var _user_type = ""
var _phone = ""
var _email = ""
var _company_name = ""
var _percentage = ""
var _points = ""
var _total_paid = ""
var _projects = ""
var _img = ""
    
    init(id : String ,
        name : String ,
        user_type : String ,
        phone : String ,
        email : String ,
        company_name : String ,
        percentage : String ,
        points : String ,
        total_paid : String ,
        projects : String ,
        img : String) {
        
        self._id = id
        self._name = name
        self._user_type = user_type
        self._phone = phone
        self._email = email
        self._company_name = company_name
        self._percentage = percentage
        self._points = points
        self._total_paid = total_paid
        self._projects = projects
        self._img = img
    }
}
