//
//  AaqdVerificationCode.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/28/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit
import SwiftyJSON
class AaqdVerificationCode: UIViewController {

    var ContractID = ""
    var http = HttpHelper()
    @IBOutlet weak var txtCode: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        SendCode()
        http.delegate = self
        
        let attributes = [NSAttributedString.Key.font: UIFont(name: "DINNextLTW23-Regular", size: 20)!]
        UINavigationBar.appearance().titleTextAttributes = attributes
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnSideMenue(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Projects", bundle: nil)
        let cont = storyboard.instantiateViewController(withIdentifier: "RightMenuNavigationController")
        cont.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        cont.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        self.present(cont, animated: true, completion: nil)
    }
    @IBAction func DismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func btnVerify(_ sender: Any) {
        
    }
    
    func SendCode(){
        print(ContractID)
        let AccessToken = AppCommon.sharedInstance.getJSON("Profiledata")["token"].stringValue
        print(AccessToken)
        let params = ["token": AccessToken ,
                      "contract_id" : ContractID] as [String: Any]
        //let headers = ["Authorization": AccessToken]
        //AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.SendContractCode, method: .post, parameters: params, tag: 3, header: nil)
    }
    func confirm(){
        let AccessToken = AppCommon.sharedInstance.getJSON("Profiledata")["token"].stringValue
        let params = [
            "token": AccessToken ,
            "contract_id" : ContractID ,
            "code": txtCode.text!] as [String: Any]
        let headers = ["Authorization": AccessToken]
        //AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.CheckContractCode, method: .post, parameters: params, tag: 2, header: headers)
    }
}
extension AaqdVerificationCode : HttpHelperDelegate {
    func receivedResponse(dictResponse: Any, Tag: Int) {
        print(dictResponse)
        AppCommon.sharedInstance.dismissLoader(self.view)
        let json = JSON(dictResponse)
        if  Tag == 2 {
            let status =  json["status"]
            let message = json["msg"]
            
            if status.stringValue == "0" {
                Loader.showSuccess(message: message.stringValue)
                let sb = UIStoryboard(name: "ProjectDetails", bundle: nil)
                let controller = sb.instantiateViewController(withIdentifier: "ProjectMessagesVC") as! LoginVC
                self.show(controller, sender: true)
                
            } else {
                Loader.showError(message: message.stringValue )
            }
        }else if Tag == 3 {
            let status =  json["status"]
            let message = json["msg"]
            
            if status.stringValue == "0" {
                Loader.showSuccess(message: message.stringValue)
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

