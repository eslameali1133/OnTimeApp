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
    override func viewDidLoad() {
        super.viewDidLoad()
        http.delegate = self
        btnSend.layer.cornerRadius = 30
        btnSend.layer.borderWidth = 1
        btnSend.layer.borderColor = UIColor.white.cgColor
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
             else{
                
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

