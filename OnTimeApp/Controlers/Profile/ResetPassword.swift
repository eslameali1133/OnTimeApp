//
//  ResetPassword.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 7/1/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit
import SwiftyJSON
class ResetPassword: UIViewController {

    var http = HttpHelper()
    var Token = ""
    var Email = ""
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        http.delegate = self
        
        print(Email)
        print(Token)
        
    }
    
    @IBAction func btnConfirm(_ sender: Any) {
        if validation(){
            ResetPassword()
        }
    }
    
    func validation () -> Bool {
        var isValid = true
        if txtConfirmPassword.text! != txtPassword.text { Loader.showError(message: AppCommon.sharedInstance.localization("Password and Confirm password is not match!"))
            isValid = false
        }
        
        if (txtPassword.text?.count)! < 6 { Loader.showError(message: AppCommon.sharedInstance.localization("Password must be at least 6 characters long"))
            isValid = false
        }
        if txtPassword.text! == "" { Loader.showError(message: AppCommon.sharedInstance.localization("Password field cannot be left blank"))
            isValid = false
        }
        
        
        return isValid
    }
    
    func ResetPassword(){
        let headers = [
            "Authorization": Token]
        let params = [
            "token": Token ,
            "new_password":txtPassword.text!
            ] as [String: Any]
        print(Email)
        print(Token)
        
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.NewPassword, method: .post, parameters: params, tag: 1, header: headers)
    }
    
    @IBAction func DismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension ResetPassword : HttpHelperDelegate {
    func receivedResponse(dictResponse: Any, Tag: Int) {
        print(dictResponse)
        AppCommon.sharedInstance.dismissLoader(self.view)
        let json = JSON(dictResponse)
        print(json)
        
        if Tag == 1 {
            let status =  json["status"]
            let message = json["msg"]
            
            //print(json["status"])
            if status.stringValue == "0" {
                
//                UserDefaults.standard.set(access_token.stringValue, forKey: "access_token")
//                UserDefaults.standard.set(token_type.stringValue, forKey: "token_type")
//                //  UserDefaults.standard.set(data.array, forKey: "Profiledata")
//                UserDefaults.standard.set(expires_at.stringValue, forKey: "expires_at")
//                AppCommon.sharedInstance.saveJSON(json: data, key: "Profiledata")
//                // UserDefaults.standard.array(forKey: "Profiledata")
//                // print(data["email"])
//                print(AppCommon.sharedInstance.getJSON("Profiledata")["phone"].stringValue)
//                // let storyboard = UIStoryboard(name: "StoryBord", bundle: nil)
                
                let sb = UIStoryboard(name: "Profile", bundle: nil)
                let controller = sb.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                self.show(controller, sender: true)
            }
            else {
                Loader.showError(message: message.stringValue )
            }
            
            
        } 
    }
    func receivedErrorWithStatusCode(statusCode: Int) {
        print(statusCode)
        AppCommon.sharedInstance.alert(title: "Error", message: "\(statusCode)", controller: self, actionTitle: AppCommon.sharedInstance.localization("ok"), actionStyle: .default)
        
        AppCommon.sharedInstance.dismissLoader(self.view)
    }
    func retryResponse(numberOfrequest: Int) {
        
    }
    
}
