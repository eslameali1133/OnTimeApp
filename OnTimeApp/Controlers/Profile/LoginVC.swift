//
//  LoginVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/12/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit
import SwiftyJSON
class LoginVC: UIViewController {

    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    var http = HttpHelper()
    override func viewDidLoad() {
        super.viewDidLoad()

        http.delegate = self
        btnLogin.layer.cornerRadius = 25
        btnLogin.layer.borderWidth = 1
        btnLogin.layer.borderColor = UIColor.white.cgColor
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnLogin(_ sender: Any) {
        
        if validation(){
            print("valid")
            Login ()
        
    }
    }
    func validation () -> Bool {
        var isValid = true
        
        //Password Validation
        
        if txtPassword.text! == "" { Loader.showError(message: AppCommon.sharedInstance.localization("Password field cannot be left blank"))
            isValid = false
        }
        
        //Phone Number Validation
        
        if  txtUserName.text! == "" {
            Loader.showError(message: AppCommon.sharedInstance.localization("User Name field cannot be left blank"))
            isValid = false
        }
        
        return isValid
    }
    
    func Login() {
        let params = [
            "phone":txtUserName.text!,
            "password":txtPassword.text!
            ] as [String: Any]
        //let headers = ["Accept": "application/json" ,   "lang":SharedData.SharedInstans.getLanguage() ,"Content-Type": "application/json"]
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.Login, method: .post, parameters: params, tag: 1, header: nil)
    }
    func ResendCode(){
        let AccessToken = AppCommon.sharedInstance.getJSON("Profiledata")["token"].stringValue
        print(AccessToken)
        let params = ["token": AccessToken] as [String: Any]
        let headers = [
            "Authorization": AccessToken]
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.SendCode, method: .post, parameters: params, tag: 3, header: headers)
    }
    

}
extension LoginVC: HttpHelperDelegate {
    func receivedResponse(dictResponse: Any, Tag: Int) {
        print(dictResponse)
        AppCommon.sharedInstance.dismissLoader(self.view)
        
        let json = JSON(dictResponse)
        if Tag == 1 {
            
            let status =  json["status"]
            let Message = json["msg"]
            let data = json["data"]
            let token = json["token"]
            print(token)
            print(status)
            print(Message)
            print(data)
            
            if status.stringValue  == "0" {
               // UserDefaults.standard.set(Token.stringValue, forKey: "access_token")
              //  UserDefaults.standard.set(Name.stringValue, forKey: "user_name")
                //UserDefaults.standard.set(Email.stringValue, forKey: "user_email")
        
               // ChatToken = UserDefaults.standard.string(forKey: "chat_token")!
                AppCommon.sharedInstance.saveJSON(json: data, key: "Profiledata")
                print(AppCommon.sharedInstance.getJSON("Profiledata")["token"].stringValue)
                SharedData.SharedInstans.SetIsLogin(true)
                
                let delegate = UIApplication.shared.delegate as! AppDelegate
                // let storyboard = UIStoryboard(name: "StoryBord", bundle: nil)
                let storyboard = UIStoryboard.init(name: "Projects", bundle: nil); delegate.window?.rootViewController = storyboard.instantiateInitialViewController()
           
            }else if status.stringValue == "213"{
                Loader.showError(message: Message.stringValue)
                let storyBoard : UIStoryboard = UIStoryboard(name: "Profile", bundle:nil)
                let cont = storyBoard.instantiateViewController(withIdentifier: "VerificationCodeVC")as! VerificationCodeVC
                //print(UserDefaults.standard.string(forKey: "code"))
                cont.Token = token.stringValue
                cont.isLogin = true
                self.present(cont, animated: true, completion: nil)
            }
            else {
                Loader.showError(message: Message.stringValue)
            }
            
       
        }else if Tag == 3 {
            
            let status =  json["status"]
            let code = json["code"]
            print(status)
            print(code)
            if status.stringValue  == "2" {
                let sb = UIStoryboard(name: "Profile", bundle: nil)
              //  let controller = sb.instantiateViewController(withIdentifier: "EnterVerificationCodeVC") as! EnterVerificationCodeVC
                
                print(code.stringValue)
                //controller.vereficationCode = code.stringValue
                //controller.Phone = AppCommon.sharedInstance.getJSON("Profiledata")["phone"].stringValue
               // controller.isRegister = true
               // self.show(controller, sender: true)
                
            } else if status.stringValue  == "3" {
                
                let message = json["message"]
                Loader.showError(message: message.stringValue )
                
            } else {
                
                let message = json["message"]
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

