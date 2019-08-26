//
//  Profile.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/28/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class Profile: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource , UIImagePickerControllerDelegate ,UINavigationControllerDelegate {
    var ability = ""
    var type = ""
    var policyChecked = false
    var invoicChecked = false
    var AlertController: UIAlertController!
    let imgpicker = UIImagePickerController()
    @IBOutlet weak var lblKey: UILabel!
    @IBOutlet weak var lblPeopleName: UITextField!
    @IBOutlet weak var lblOrgName: UITextField!
    @IBOutlet weak var lblPhone: UITextField!
    @IBOutlet weak var lblPassword: UITextField!
    @IBOutlet weak var lblConfirmPassword: UITextField!
    @IBOutlet weak var lblEmail: UITextField!
    var KeyNumber = ["+966" , "+973" , "+20" , "+970" , "+249", "+252", "+974" , "+968" , "+963" , "+213" , "+964" , "+269" , "+212" , "+965" , "+216" , "+222" , "+967" , "+971" , "+962" , "+218" , "+961" , "+253"]
    var pickerview  = UIPickerView()
    var toolBar = UIToolbar()
    @IBOutlet weak var imgProfile:  customImageView!{
    didSet{
    imgProfile.layer.cornerRadius =  imgProfile.frame.width / 2
    imgProfile.layer.borderWidth = 1
    //            ProfileImageView.layer.borderColor =  UIColor(red: 0, green: 156, blue: 158, alpha: 1) as! CGColor
    
    imgProfile.clipsToBounds = true
    
    }
    }
    @IBOutlet weak var chekInvoice: UIImageView!
    @IBOutlet weak var imgPeople: UIImageView!
    @IBOutlet weak var imgOrg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupUploadImage()
        SetData()
//        lblKey.text = "+966"
        
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DINNextLTW23-Regular", size: 20.0)!]
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSend(_ sender: Any) {
        EditProfile()
    }
    @IBAction func btnUoloadImg(_ sender: Any) {
        imgpicker.delegate = self
        imgpicker.allowsEditing = false
        self.present(AlertController, animated: true, completion: nil)
    }
    @IBAction func btnKey(_ sender: Any) {
        onDoneButtonTapped()
        configurePicker()
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
        type = "company"
        imgOrg.image = UIImage(named: "radio-on-button (3)")
        imgPeople.image = UIImage(named: "radio-on-button (4)")
    }
    @IBAction func btnPeople(_ sender: Any) {
        type = "single"
        imgPeople.image = UIImage(named: "radio-on-button (3)")
        imgOrg.image = UIImage(named: "radio-on-button (4)")
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
    //single - company
    func SetData(){
        let phonenum : String = AppCommon.sharedInstance.getJSON("Profiledata")["phone"].stringValue
        print(phonenum.prefix(3))
        
        lblKey.text = String(phonenum.prefix(3))
        lblPhone.text = String(phonenum.dropFirst(3))
        
//        lblPhone.text = AppCommon.sharedInstance.getJSON("Profiledata")["phone"].stringValue
        lblEmail.text = AppCommon.sharedInstance.getJSON("Profiledata")["email"].stringValue
        type = AppCommon.sharedInstance.getJSON("Profiledata")["user_type"].stringValue
        if type == "single"{
            imgPeople.image = UIImage(named: "radio-on-button (3)")
            imgOrg.image = UIImage(named: "radio-on-button (4)")
        }else if type == "company"{
            imgOrg.image = UIImage(named: "radio-on-button (3)")
            imgPeople.image = UIImage(named: "radio-on-button (4)")
        }
        lblOrgName.text = AppCommon.sharedInstance.getJSON("Profiledata")["company_name"].stringValue
        imgProfile.loadimageUsingUrlString(url: AppCommon.sharedInstance.getJSON("Profiledata")["img"].stringValue)
        lblPeopleName.text = AppCommon.sharedInstance.getJSON("Profiledata")["name"].stringValue
    }
    
    func SetupUploadImage()
    {
        AlertController = UIAlertController(title:"" , message:"إختر الصورة" , preferredStyle: UIAlertController.Style.actionSheet)
        
        let Cam = UIAlertAction(title: "الكاميرا", style: UIAlertAction.Style.default, handler: { (action) in
            self.openCame()
        })
        let Gerall = UIAlertAction(title: "المعرض", style: UIAlertAction.Style.default, handler: { (action) in
            self.opengelar()
        })
        
        let Cancel = UIAlertAction(title: "إلغاء", style: UIAlertAction.Style.cancel, handler: { (action) in
            //
        })
        
        self.AlertController.addAction(Cam)
        self.AlertController.addAction(Gerall)
        self.AlertController.addAction(Cancel)
    }
    
    func EditProfile(){
    
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        let Phone = lblKey.text! + lblPhone.text!
    
        let AccessToken = AppCommon.sharedInstance.getJSON("Profiledata")["token"].stringValue
        var parameters = [:] as [String: Any]
        
        print(AccessToken)
        let imgdata = self.imgProfile.image!.jpegData(compressionQuality: 0.5)
        print(imgdata!)
        let UserParams = [
            "token":AccessToken,
            "name" : lblPeopleName.text!,
            "email" : lblEmail.text!,
            "phone" : Phone ,
            "user_type" : type ,
            "img" : imgdata! ] as [String: Any]
        
        let OrgParams = ["token":AccessToken,
                         "name" : lblPeopleName.text!,
                         "email" : lblEmail.text!,
                         "phone" : Phone,
                         "user_type" : type,
                         "company_name" : lblOrgName.text! ,
                         "ability" : "" ,
                         "img" : imgdata!] as [String: Any]
        if type == "single"{
            parameters = UserParams
            print(parameters)
        }else if type == "company"{
            parameters = OrgParams
            print(parameters)
        }
        
        print(parameters)
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                for (key,value) in parameters {
                    if let value = value as? String {
                        multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    }
                }
                
                
//
//                if let data = self.imgProfile.image!.jpegData(compressionQuality: 0.5){
//
//                    multipartFormData.append(data, withName: "img", fileName: "img\(arc4random_uniform(100))"+".jpeg", mimeType: "jpeg")
//
//                }
                
                
                if let profiledata = self.imgProfile.image!.jpegData(compressionQuality: 0.5){
                    multipartFormData.append(profiledata, withName: "img", fileName: "imgphoto\(arc4random_uniform(100))"+".jpeg", mimeType: "image/jpeg")
                }
                
                
                
                
        },
            usingThreshold:UInt64.init(),
            to: "https://appontime.net/mobile/edit_profile.php",
            method: .post, headers: nil,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (progress) in
                        print(progress)
                    })
                    upload.responseJSON { response in
                        debugPrint(response)
                        // If the request to get activities is succesfull, store them
                        if response.result.isSuccess{
                            print(response.debugDescription)
                            AppCommon.sharedInstance.dismissLoader(self.view)
                            // print(response.data!)
                            // print(response.result)
                            let json = JSON(response.data)
                            print(json)
                            let status =  json["status"]
                            let message = json["msg"]
                            let data = json["data"]
                            if status.stringValue == "0" {
                                
                                Loader.showSuccess(message: AppCommon.sharedInstance.localization("The Profile was successfully Editted"))
                                AppCommon.sharedInstance.saveJSON(json: data, key: "Profiledata")
                                print(AppCommon.sharedInstance.getJSON("Profiledata")["company_name"].stringValue)
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Projects", bundle:nil)
                                let cont = storyBoard.instantiateViewController(withIdentifier: "ProfileNAV")
                                self.revealViewController()?.pushFrontViewController(cont, animated: true)
                            
                            }else{
                                Loader.showError(message: message.stringValue)
                            }
                            
                        } else {
                            let errorMessage = "ERROR MESSAGE: "
                            if let data = response.data {
                                // Print message
                                print(errorMessage)
                                AppCommon.sharedInstance.dismissLoader(self.view)
                                
                                
                                
                            }
                            print(errorMessage) //Contains General error message or specific.
                            print(response.debugDescription)
                            AppCommon.sharedInstance.dismissLoader(self.view)
                        }
                        
                        
                    }
                case .failure(let encodingError):
                    print("FALLE ------------")
                    print(encodingError)
                    AppCommon.sharedInstance.dismissLoader(self.view)
                }
        }
        )
    }
    
    func openCame(){
        
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func opengelar(){
        
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ imgpicker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        imgProfile.image = selectedImage
        
        imgpicker.dismiss(animated: true, completion: nil)
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

