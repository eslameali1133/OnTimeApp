//
//  SignUpVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/13/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit
import SwiftyJSON
class SignUpVC: UIViewController {

    var ability = ""
    var type = ""
    var http = HttpHelper()
    var policyChecked = false
    var invoicChecked = false

    @IBOutlet weak var txtConfirmPass: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtOrgName: UITextField!
    @IBOutlet weak var chekPolicy: UIImageView!
    @IBOutlet weak var chekInvoice: UIImageView!
    @IBOutlet weak var imgPeople: UIImageView!
    @IBOutlet weak var imgOrg: UIImageView!
    var KeyNumber = ["+966" , "+973" , "+20" , "+970" , "+249", "+252", "+974" , "+968" , "+963" , "+213" , "+964" , "+269" , "+212" , "+965" , "+216" , "+222" , "+967" , "+971" , "+962" , "+218" , "+961" , "+253"]
    var pickerview  = UIPickerView()
    
    @IBOutlet weak var lblKey: UILabel!
    var toolBar = UIToolbar()
    @IBOutlet weak var btnSignUp: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        ability = "0"
        type = "Organization"
        imgOrg.image = UIImage(named: "radio-on-button (3)")
        imgPeople.image = UIImage(named: "radio-on-button (4)")
        http.delegate = self
        lblKey.text = "+966"
        btnSignUp.layer.cornerRadius = 20
        btnSignUp.layer.borderWidth = 1
        btnSignUp.layer.borderColor = UIColor.white.cgColor
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnTermsConditions(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let cont = storyboard.instantiateViewController(withIdentifier: "TermsVC")
        
        self.present(cont, animated: true, completion: nil)
    }
    @IBAction func btnCheckInvoce(_ sender: Any) {
        if invoicChecked == false {
            chekInvoice.image = UIImage(named: "check")
            ability = "1"
            invoicChecked = true
        }else{
            chekInvoice.image = UIImage(named: "check (1)")
            ability = "0"
            invoicChecked = false
        }
    }
    @IBAction func btnOrg(_ sender: Any) {
        type = "Organization"
        imgOrg.image = UIImage(named: "radio-on-button (3)")
        imgPeople.image = UIImage(named: "radio-on-button (4)")
    }
    @IBAction func btnPeople(_ sender: Any) {
        type = "People"
        imgPeople.image = UIImage(named: "radio-on-button (3)")
        imgOrg.image = UIImage(named: "radio-on-button (4)")
    }
    @IBAction func btnCheckPolicy(_ sender: Any) {
        if policyChecked == false {
            chekPolicy.image = UIImage(named: "check")
            policyChecked = true
        }else{
            chekPolicy.image = UIImage(named: "check (1)")
            policyChecked = false
        }
    }
    @IBAction func btnKey(_ sender: Any) {
        onDoneButtonTapped()
        configurePicker()
        
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
        if validation(){
            print("valid")
            signup ()
        }
    }
   
    
    @IBAction func DismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func validation () -> Bool {
            var isValid = true
        
        let emailAddress = txtEmail.text?.lowercased()
        let finalEmail = emailAddress?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        //Password Validation
        
        if txtPassword.text! != txtConfirmPass.text { Loader.showError(message: AppCommon.sharedInstance.localization("Password and Confirm password is not match!"))
                isValid = false
            }
            
            if (txtPassword.text?.count)! < 6 { Loader.showError(message: AppCommon.sharedInstance.localization("Password must be at least 6 characters long"))
                isValid = false
            }
            if txtPassword.text! == "" { Loader.showError(message: AppCommon.sharedInstance.localization("Password field cannot be left blank"))
                isValid = false
            }
        
        //Phone Number Validation
        
              if  txtPhone.text! == "" {
            Loader.showError(message: AppCommon.sharedInstance.localization("Phone field cannot be left blank"))
            isValid = false
        }
        
        // Name validation
        
        if txtName.text! == "" {
            Loader.showError(message: AppCommon.sharedInstance.localization("Name field cannot be left blank"))
            isValid = false
        }
        
        if txtOrgName.text! == "" {
            Loader.showError(message: AppCommon.sharedInstance.localization("Name field cannot be left blank"))
            isValid = false
        }
        
        // Email Validation
        
        if isValidEmail(userEmail: finalEmail!) == false{
            Loader.showError(message: AppCommon.sharedInstance.localization("Not Valied Email Address"))
            isValid = false
            
        }
        
        if txtEmail.text! == "" {
            Loader.showError(message: AppCommon.sharedInstance.localization("Email field cannot be left blank"))
            isValid = false
        }
        if policyChecked == false  {
            Loader.showError(message: AppCommon.sharedInstance.localization("You must agree to the terms and conditions"))
            isValid = false
        }
        
        
        return isValid
    }
    
    //  Email Validation Function
    
    func isValidEmail(userEmail:String) -> Bool {
        
        let emailRegEx = "[A-Za-z0-9.%+-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@",emailRegEx).evaluate(with:userEmail)
    }

    
    func signup () {
        
        let Phone = lblKey.text! + txtPhone.text!
        print(Phone)
        let UserParams = [
            "name":txtName.text!,
            "email" : txtEmail.text!,
            "phone" : Phone,
            "password" : txtPassword.text! ] as [String: Any]
        
        let OrgParams = ["name":txtName.text!,
                         "email" : txtEmail.text!,
                         "phone" : Phone,
                         "password" : txtPassword.text!,
                         "company_name" : txtOrgName.text!,
                         "ability" : ability] as [String: Any]
        
            let headers = ["Accept-Type": "application/json" ,   "lang":SharedData.SharedInstans.getLanguage() , "Content-Type": "application/json"]
            AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        if type == "Organization" {
            http.requestWithBody(url: APIConstants.RegisterCompany, method: .post, parameters: OrgParams, tag: 1, header: nil)
        }else if type == "People" {
            http.requestWithBody(url: APIConstants.RegisterUser, method: .post, parameters: UserParams, tag: 1, header: nil)
        }
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
}
extension SignUpVC: UIPickerViewDelegate , UIPickerViewDataSource {
    
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

extension SignUpVC: HttpHelperDelegate {
    func receivedResponse(dictResponse: Any, Tag: Int) {
        print(dictResponse)
        AppCommon.sharedInstance.dismissLoader(self.view)
        let json = JSON(dictResponse)
        print(json)
        if Tag == 1 {
            
                let status =  json["status"]
                let message = json["msg"]
                let access_token = json["token"]
                let ID = json["lastid"]
                
                if status.stringValue == "0" {
                    
                    UserDefaults.standard.set(access_token.stringValue, forKey: "access_token")
                    UserDefaults.standard.set(ID.stringValue, forKey: "ID")
                    UserDefaults.standard.set(txtName.text, forKey: "Name")
                    UserDefaults.standard.set(txtEmail.text, forKey: "Email")
                    UserDefaults.standard.set(txtPhone.text, forKey: "Phone")
                    UserDefaults.standard.set(txtPassword.text, forKey: "Password")
                    if type == "Organization" {
                        UserDefaults.standard.set(txtOrgName.text, forKey: "OrgName")
                        UserDefaults.standard.set(ability, forKey: "ability")
                    }
//                    AppCommon.sharedInstance.saveJSON(json: data, key: "Profiledata")
//                    // UserDefaults.standard.array(forKey: "Profiledata")
                    // print(data["email"])
                    //print(AppCommon.sharedInstance.getJSON("Profiledata")["phone"].stringValue)
                    
                                    let storyBoard : UIStoryboard = UIStoryboard(name: "Profile", bundle:nil)
                                   let cont = storyBoard.instantiateViewController(withIdentifier: "VerificationCodeVC")as! VerificationCodeVC
                                   //print(UserDefaults.standard.string(forKey: "code"))
                                    cont.Token = UserDefaults.standard.string(forKey: "access_token")!
                                    cont.isRegister = true
                                    self.present(cont, animated: true, completion: nil)
                    
                }else {
                    //let message = json["message"]
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
