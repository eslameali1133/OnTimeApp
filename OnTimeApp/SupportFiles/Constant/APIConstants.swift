//
//  APIConstants.swift
//  CarWash
//
//  Created by Mohammad Farhan on 22/12/1710/11/17.
//  Copyright © 2017 CarWash. All rights reserved.
//

import Foundation

open class APIConstants {
   static let SERVER_URL = "https://appontime.net/mobile/"
      static let Base_Image_URL = "http://172.107.175.8/taqsema/public/"
    
    static let RegisterUser = SERVER_URL + "register_user.php"
    static let RegisterCompany = SERVER_URL + "register_company.php"
    static let Login = SERVER_URL + "login.php"
    static let SendCode = SERVER_URL + "send_vcode.php"
    static let ForgetPassword = SERVER_URL + "forget_password.php"
    static let CheckVCode = SERVER_URL + "check_vcode.php"
    static let CheckPCode = SERVER_URL + "check_pcode.php"
    static let NewPassword = SERVER_URL + "add_new_password.php"
    static let GetDepartment = SERVER_URL + "get_departments.php"
    static let GetServices = SERVER_URL + "get_service.php"
    static let AddRequest = SERVER_URL + "add_request.php"
    
    static let GetUserRequests = SERVER_URL + "get_user_requests.php"
    static let GetUserProfile = SERVER_URL + "get_profile.php"
    static let Terms = SERVER_URL + "get_terms.php"
    static let aboutUs = SERVER_URL + "who_we_are.php"
    
    static let SendContractCode = SERVER_URL + "send_contract_code.php"
    static let CheckContractCode = SERVER_URL + "check_contract_code.php"
    static let GetRequestContract = SERVER_URL + "get_request_contract.php"
    
    static let GetRequestDetails = SERVER_URL + "request_details.php"
    static let RecieveProject = SERVER_URL + "get_finished_project.php"
    static let SendRate = SERVER_URL + "add_finish_comment.php"
    
    static let GetNotificatios = SERVER_URL + "get_user_notification.php"
    static let ReadNotification = SERVER_URL + "read_notification.php"
    
}
