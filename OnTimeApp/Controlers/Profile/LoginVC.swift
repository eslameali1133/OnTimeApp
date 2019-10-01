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

    var KeyNumber = ["+966" , "+973" , "+20" , "+970" , "+249", "+252", "+974" , "+968" , "+963" , "+213" , "+964" , "+269" , "+212" , "+965" , "+216" , "+222" , "+967" , "+971" , "+962" , "+218" , "+961" , "+253"]
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    var http = HttpHelper()
    var pickerview  = UIPickerView()
    @IBOutlet weak var lblKey: UILabel!
    var toolBar = UIToolbar()
    override func viewDidLoad() {
        super.viewDidLoad()
        lblKey.text = "+966"
        http.delegate = self
        btnLogin.layer.cornerRadius = 25
        //btnLogin.layer.borderWidth = 1
        //btnLogin.layer.borderColor = UIColor.white.cgColor
        btnLogin.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        btnLogin.layer.shadowOffset = CGSize(width: 0, height: 4)
        btnLogin.layer.shadowOpacity = 1.0
        btnLogin.layer.shadowRadius = 3.0
        btnLogin.layer.masksToBounds = false
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnKey(_ sender: Any) {
        onDoneButtonTapped()
        configurePicker()
        
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
        let Phone = lblKey.text! + txtUserName.text!
        print(Phone)
        let params = [
            "phone":Phone,
            "password":txtPassword.text!,
            "fcm_token": "\(UserDefaults.standard.string(forKey: "token")!)"
            ] as [String: Any]
        //let headers = ["Accept": "application/json" ,   "lang":SharedData.SharedInstans.getLanguage() ,"Content-Type": "application/json"]
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.Login, method: .post, parameters: params, tag: 1, header: nil)
    }
    
    func configurePicker (){
        pickerview = UIPickerView.init()
        pickerview.delegate = self
        pickerview.backgroundColor = UIColor.white
        pickerview.setValue(UIColor.black, forKey: "textColor")
        pickerview.autoresizingMask = .flexibleWidth
        pickerview.contentMode = .center
        pickerview.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 255)
        self.view.addSubview(pickerview)
        
        
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .default
        
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .plain, target: self, action: #selector(onDoneButtonTapped))]
        
        
        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        pickerview.removeFromSuperview()
        self.view.endEditing(true)
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
extension LoginVC: UIPickerViewDelegate , UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return KeyNumber.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(KeyNumber[row])
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        lblKey.text = KeyNumber[row]
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
            let token = data["token"]
            print(token)
            print(status)
            print(Message)
            print(data)
            
            if status.stringValue  == "0" {
               let Phone = lblKey.text! + txtUserName.text!
               UserDefaults.standard.set(txtPassword.text, forKey: "Password")
               UserDefaults.standard.set(Phone, forKey: "Phone")
                //UserDefaults.standard.set(Email.stringValue, forKey: "user_email")
        
               // ChatToken = UserDefaults.standard.string(forKey: "chat_token")!
                AppCommon.sharedInstance.saveJSON(json: data, key: "Profiledata")
                print(AppCommon.sharedInstance.getJSON("Profiledata")["token"].stringValue)
                SharedData.SharedInstans.SetIsLogin(true)
                
                let delegate = UIApplication.shared.delegate as! AppDelegate
                // let storyboard = UIStoryboard(name: "StoryBord", bundle: nil)
                let storyboard = UIStoryboard.init(name: "Projects", bundle: nil); delegate.window?.rootViewController = storyboard.instantiateInitialViewController()

           
            }else if status.stringValue == "213"{
                let Token = json["token"]
                print(Token)
                Loader.showError(message: Message.stringValue)
                let storyBoard : UIStoryboard = UIStoryboard(name: "Profile", bundle:nil)
                let cont = storyBoard.instantiateViewController(withIdentifier: "VerificationCodeVC")as! VerificationCodeVC
                //print(UserDefaults.standard.string(forKey: "code"))
                cont.Token = Token.stringValue
                cont.isLogin = true
                self.present(cont, animated: true, completion: nil)
            }else if status.stringValue == "500"{
                Loader.showError(message: AppCommon.sharedInstance.localization("Wrong request type"))
            }else if status.stringValue == "1"{
                Loader.showError(message: AppCommon.sharedInstance.localization("some missing data"))
            }else if status.stringValue == "204"{
                Loader.showError(message: AppCommon.sharedInstance.localization("un authorized"))
            }else if status.stringValue == "505"{
                Loader.showError(message: AppCommon.sharedInstance.localization("error"))
            }else if status.stringValue == "212"{
                Loader.showError(message: AppCommon.sharedInstance.localization("wrong phone or password "))
            }else {
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

