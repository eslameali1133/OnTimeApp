//
//  ForgetPasswordVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/12/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit
import SwiftyJSON
class ForgetPasswordVC: UIViewController {

    var http = HttpHelper()
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if  SharedData.SharedInstans.getLanguage() != "en" {
            btnBack.setImage(UIImage(named: "arrow-in-circle-point-to-up-1") , for: .normal)
        }
        http.delegate = self
        btnSend.layer.cornerRadius = 25
        //btnSend.layer.borderWidth = 1
        //btnSend.layer.borderColor = UIColor.white.cgColor
        btnSend.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        btnSend.layer.shadowOffset = CGSize(width: 0, height: 4)
        btnSend.layer.shadowOpacity = 1.0
        btnSend.layer.shadowRadius = 3.0
        btnSend.layer.masksToBounds = false
        // Do any additional setup after loading the view.
    }
    

    @IBAction func DismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnSend(_ sender: Any) {
        if validation(){
            sendCode()
        }
    }
    
    func validation () -> Bool {
        var isValid = true
        
        if txtEmail.text! == "" {
            Loader.showError(message: AppCommon.sharedInstance.localization("Phone field cannot be left blank"))
            isValid = false
        }
        
        
        return isValid
    }
    
    func sendCode(){
        print(txtEmail.text!)
        let params = ["email":txtEmail.text!] as [String: Any]
    //AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.ForgetPassword, method: .post, parameters: params, tag: 1, header: nil)
    }
}
extension ForgetPasswordVC : HttpHelperDelegate {
    func receivedResponse(dictResponse: Any, Tag: Int) {
        print(dictResponse)
//        AppCommon.sharedInstance.dismissLoader(self.view)
        let json = JSON(dictResponse)
        
        if Tag == 1 {
            
            let status =  json["status"]
            let Message =  json["msg"]
            let Token =  json["token"]
            let code = json["pcode"]
            if status.stringValue  == "0" {
                let sb = UIStoryboard(name: "Profile", bundle: nil)
                let controller = sb.instantiateViewController(withIdentifier: "VerificationCodeVC") as! VerificationCodeVC
                
               // print(txtPhone.text!)
               // print(code.stringValue)
               controller.vereficationCode = code.stringValue
               controller.Email = txtEmail.text!
                controller.isRegister = false
                controller.Token = Token.stringValue
               self.show(controller, sender: true)
            }
            else if status.stringValue == "500"{
                Loader.showError(message: AppCommon.sharedInstance.localization("Wrong request type"))
            }else if status.stringValue == "1"{
                Loader.showError(message: AppCommon.sharedInstance.localization("some missing data"))
            }else if status.stringValue == "204"{
                Loader.showError(message: AppCommon.sharedInstance.localization("un authorized"))
            }else if status.stringValue == "206"{
                Loader.showError(message: AppCommon.sharedInstance.localization("Send failed"))
            }else{
                
                Loader.showError(message: Message.stringValue )
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

