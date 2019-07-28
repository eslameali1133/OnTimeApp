//
//  MakeAaqdVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/28/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class MakeAaqdVC: UIViewController , UIImagePickerControllerDelegate ,UINavigationControllerDelegate {

    var RequestID = ""
    var http = HttpHelper()
    var AlertController: UIAlertController!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtPID: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    let imgpicker = UIImagePickerController()
    @IBOutlet weak var imgPID: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        print(RequestID)
       // http.delegate = self
        SetupUploadImage()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnUploadImage(_ sender: Any) {
        imgpicker.delegate = self
        imgpicker.allowsEditing = false
        self.present(AlertController, animated: true, completion: nil)
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
    @IBAction func btnMakeContract(_ sender: Any) {
        if validation(){
            AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
            UpdateProfile()
        }
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
        
        imgPID.image = selectedImage
        
        imgpicker.dismiss(animated: true, completion: nil)
    }

    func validation () -> Bool {
        var isValid = true
        
        
        
        if txtPhone.text! == "" {
            Loader.showError(message: AppCommon.sharedInstance.localization("Phone field cannot be left blank"))
            isValid = false
        }
        if txtName.text! == "" { Loader.showError(message: AppCommon.sharedInstance.localization("Name field cannot be left blank"))
            isValid = false
        }
        if txtPID.text! == "" { Loader.showError(message: AppCommon.sharedInstance.localization("PID field cannot be left blank"))
            isValid = false
        }
        
        if txtEmail.text! == "" { Loader.showError(message: AppCommon.sharedInstance.localization("Email field cannot be left blank"))
            isValid = false
        }
        
        
        return isValid
    }
    
    
    func UpdateProfile() {
        let AccessToken = AppCommon.sharedInstance.getJSON("Profiledata")["token"].stringValue
        var parameters = [:] as [String: Any]

        print(AccessToken)
        let imgdata = self.imgPID.image!.jpegData(compressionQuality: 0.5)
        print(imgdata!)
        parameters = [
            "request_id" : RequestID,
            "token": AccessToken,
            "name": txtName.text!,
            "email" : txtEmail.text!,
            "phone": txtPhone.text!,
            "national_id": txtPID.text!,
            "img": imgdata!,
            
        ]
        
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                for (key,value) in parameters {
                    if let value = value as? String {
                        multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    }
                }
                
                if let data = self.imgPID.image!.jpegData(compressionQuality: 0.5){
                    multipartFormData.append(data, withName: "img", fileName: "img\(arc4random_uniform(100))"+".jpeg", mimeType: "jpeg")
                    
                }
                
        },
            usingThreshold:UInt64.init(),
            to: "https://appontime.net/mobile/contract_action.php",
            method: .post, headers: nil,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (progress) in
                        print(progress)
                    })
                    upload.responseJSON { response in
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
                            let ContractID = json["contract_id"]
                            if status.stringValue == "0" {
                                
                                Loader.showSuccess(message: AppCommon.sharedInstance.localization("The contract was successfully signed"))
                                
                                let sb = UIStoryboard(name: "ProjectDetails", bundle: nil)
                                let controller = sb.instantiateViewController(withIdentifier: "AaqdVerificationCode") as! AaqdVerificationCode
                                controller.ContractID = ContractID.stringValue
                                self.show(controller, sender: true)
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

}
