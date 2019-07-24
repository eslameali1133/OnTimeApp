//
//  VerificationCodeVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/12/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit
import SwiftyJSON
import KKPinCodeTextField
class VerificationCodeVC: UIViewController {

    var isLogin = false
    var isRegister = false
    var http = HttpHelper()
    var vereficationCode = ""
    var Email = ""
    var Token = ""
    @IBOutlet var popupVerefy: UIView!
    
    @IBOutlet weak var txtCode: KKPinCodeTextField!
    @IBOutlet weak var btnSend: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        if (isRegister == true) || (isLogin == true) {
            SendCode()
            btnSend.setTitle(AppCommon.sharedInstance.localization("CONFIRM"), for: .normal)
        }
        http.delegate = self
        print(vereficationCode,Email)

        popupVerefy.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(popupVerefy)
        popupVerefy.isHidden = true
       // btnSend.backgroundColor = .clear
        btnSend.layer.cornerRadius = 30
        btnSend.layer.borderWidth = 1
        btnSend.layer.borderColor = UIColor.white.cgColor
    
   

        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnResend(_ sender: Any) {
        popupVerefy.isHidden = false
        popupVerefy.backgroundColor = UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.75)
    }
    @IBAction func btnSend(_ sender: Any) {
        
        if validation(){
            if (isRegister == true) || (isLogin == true){
                isRegister = false
                isLogin = false
                confirm()
            }else{
                ResetCode()
            }
            
        }
        
    }
    
    func validation () -> Bool {
        var isValid = true
        if txtCode.text! == "" {
            Loader.showError(message: AppCommon.sharedInstance.localization("Email field cannot be left blank"))
            isValid = false
        }
        if txtCode.text! != vereficationCode {
            Loader.showError(message: AppCommon.sharedInstance.localization("please enter code you received"))
            isValid = false
        }
        
        return isValid
    }
    
    func SendCode(){
        //let AccessToken = AppCommon.sharedInstance.getJSON("Profiledata")["token"].stringValue
        print(Token)
    let params = ["token": Token] as [String: Any]
        let headers = [
            "Authorization": Token]
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.SendCode, method: .post, parameters: params, tag: 3, header: headers)
    }
    
    func confirm(){
        //let AccessToken = AppCommon.sharedInstance.getJSON("Profiledata")["token"].stringValue
        print(Token)
        let params = [
            "token": Token ,
            "code": txtCode.text!] as [String: Any]
        let headers = [
            "Authorization": Token]
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.CheckVCode, method: .post, parameters: params, tag: 2, header: headers)
    }
    
    func ResetCode(){
        let AccessToken = AppCommon.sharedInstance.getJSON("Profiledata")["token"].stringValue
        let params = [
            "token": AccessToken ,
            "code": txtCode.text!] as [String: Any]
        let headers = [
            "Authorization": AccessToken]
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.CheckPCode, method: .post, parameters: params, tag: 1, header: headers)
    }
    
    @IBAction func DismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
extension VerificationCodeVC : HttpHelperDelegate {
    func receivedResponse(dictResponse: Any, Tag: Int) {
        print(dictResponse)
        AppCommon.sharedInstance.dismissLoader(self.view)
        let json = JSON(dictResponse)
        if Tag == 1 {
            let status =  json["status"]
            let token = json["token"]
            let message = json["message"]
            print(status)
            print(token)
            
            //print(json["status"])
            if status.stringValue == "0" {
                // let storyboard = UIStoryboard(name: "StoryBord", bundle: nil)
                let sb = UIStoryboard(name: "Profile", bundle: nil)
               let controller = sb.instantiateViewController(withIdentifier: "ResetPassword") as! ResetPassword
               controller.Token = token.stringValue
             controller.Email = Email
               self.show(controller, sender: true)
                
                
            } else {
                Loader.showError(message: message.stringValue )
            }
        }else if  Tag == 2 {
            let status =  json["status"]
            let message = json["msg"]
            
            if status.stringValue == "0" {
                Loader.showSuccess(message: message.stringValue)
               // if isRegister == true {
                let sb = UIStoryboard(name: "Profile", bundle: nil)
                let controller = sb.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                self.show(controller, sender: true)
//                }
//                if isLogin == true {
//                    let delegate = UIApplication.shared.delegate as! AppDelegate
//                    // let storyboard = UIStoryboard(name: "StoryBord", bundle: nil)
//                    let storyboard = UIStoryboard.init(name: "Projects", bundle: nil); delegate.window?.rootViewController = storyboard.instantiateInitialViewController()
//                }
                
            } else {
                Loader.showError(message: message.stringValue )
            }
        }else if Tag == 3 {
            let status =  json["status"]
            let message = json["msg"]
            let code = json["vcode"]
            let NewToken = json["token"]
            print(code)
            if status.stringValue == "0" {
                Loader.showSuccess(message: message.stringValue)
                self.Token = NewToken.stringValue
                self.vereficationCode = code.stringValue
            } else {
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

