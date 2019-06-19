//
//  ProjectMessagesVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/28/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class ProjectMessagesVC: UIViewController  , UIDocumentMenuDelegate, UIDocumentPickerDelegate, UIImagePickerControllerDelegate , UINavigationControllerDelegate{

    var pickerview  = UIPickerView()
    var toolBar = UIToolbar()
    var AlertController: UIAlertController!
    let imgpicker = UIImagePickerController()
    var documentInteractionController = UIDocumentInteractionController()
    @IBOutlet var popupContractor: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        SetupActionSheet()
         popupContractor.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(popupContractor)
        popupContractor.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnRecive(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Help", bundle: nil)
        let cont = storyboard.instantiateViewController(withIdentifier: "CongratulationVC")
        
        self.present(cont, animated: true, completion: nil)
    }
    @IBAction func btnSideMenue(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Projects", bundle: nil)
        let cont = storyboard.instantiateViewController(withIdentifier: "RightMenuNavigationController")
        cont.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        cont.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        self.present(cont, animated: true, completion: nil)
    }
    
    @IBAction func btnContact(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Help", bundle: nil)
        let cont = storyboard.instantiateViewController(withIdentifier: "HelpMethodVC")
        
        self.present(cont, animated: true, completion: nil)
    }
    @IBAction func btnNotificationPayement(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Paid", bundle: nil)
        let cont = storyboard.instantiateViewController(withIdentifier: "PaymentVC")
        
        self.present(cont, animated: true, completion: nil)
    }
    @IBAction func btnPayment(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Paid", bundle: nil)
        let cont = storyboard.instantiateViewController(withIdentifier: "PaymentVC")
        
        self.present(cont, animated: true, completion: nil)
    }
    @IBAction func btnHidePopup(_ sender: Any) {
        popupContractor.isHidden = true
    }
    @IBAction func btnDetails(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ProjectDetails", bundle: nil)
        let cont = storyboard.instantiateViewController(withIdentifier: "DetailSeguVC")
        
        self.show(cont, sender: true)
    }
    
    @IBAction func btnContract(_ sender: Any) {
        popupContractor.isHidden = false
        popupContractor.backgroundColor = UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.75)
    }
    @IBAction func btnAttachment(_ sender: Any) {
        imgpicker.delegate = self
        imgpicker.allowsEditing = false
        self.present(AlertController, animated: true, completion: nil)
    }
    @IBAction func DismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func SetupActionSheet()
    {
        AlertController = UIAlertController(title:"" , message:AppCommon.sharedInstance.localization("المرفقات") , preferredStyle: UIAlertController.Style.actionSheet)
        
        let Cam = UIAlertAction(title: "الكاميرا", style: UIAlertAction.Style.default, handler: { (action) in
            self.openCameraImagePicker()
        })
        let Gerall = UIAlertAction(title: "المعرض", style: UIAlertAction.Style.default, handler: { (action) in
            self.openGalleryImagePicker()
        })
        
        let Docs = UIAlertAction(title: "الملفات", style: UIAlertAction.Style.default, handler: { (action) in
            self.openDcumentPicker()
        })
        let Map = UIAlertAction(title: "الموقع", style: UIAlertAction.Style.default, handler: { (action) in
            self.openGalleryImagePicker()
        })
        
        let Cancel = UIAlertAction(title: AppCommon.sharedInstance.localization("cancel"), style: UIAlertAction.Style.cancel, handler: { (action) in
            //
        })
        
        self.AlertController.addAction(Cam)
        self.AlertController.addAction(Gerall)
        self.AlertController.addAction(Docs)
        self.AlertController.addAction(Map)
        self.AlertController.addAction(Cancel)
    }
    
    // Delegate Method for UIDocumentMenuDelegate.
    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        self.present(documentPicker, animated: true, completion: nil)
    }
    
    // Delegate Method for UIDocumentPickerDelegate.
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        print("url: \(url)")
        let fileName = url.lastPathComponent
        print("fileName: \(fileName)")
        if (url.absoluteString.hasSuffix("pdf")) {
            print("pdf")
            
        }
        else if (url.absoluteString.hasSuffix("doc")) {
            print("doc")
            
        }
        else if (url.absoluteString.hasSuffix("docx")) {
            print("docx")
            
        }
        else if (url.absoluteString.hasSuffix("xlsx")) {
            print("xlsx")
            
        }
        else if (url.absoluteString.hasSuffix("xls")) {
            print("xls")
            
        }
        else if (url.absoluteString.hasSuffix("txt")) {
            print("txt")
            
        }
        else if (url.absoluteString.hasSuffix("pptx")) {
            print("pptx")
            
        }
        else if (url.absoluteString.hasSuffix("PPT")) {
            print("ppt")
            
        }
        else {
            print("Unknown")
        }
        
    }
    // Method to handle cancel action.
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        //        dismiss(animated: true, completion: nil)
    }
    
    func openDcumentPicker() {
        
        let pdf = String("kUTTypePDF")
        //        let zip = String(kUTTypeZipArchive)
        let docs = String("kUTTypeCompositeContent")
        //        let archive = String(kUTTypeArchive)
        let number = String("kUTTypeLog")
        let spreadsheet = String("kUTTypeSpreadsheet")
        //        let movie = String(kUTTypeMovie)
        //        let aviMovie = String(kUTTypeAVIMovie)
        let importMenu = UIDocumentMenuViewController(documentTypes: [pdf, docs, number, spreadsheet], in: UIDocumentPickerMode.import)
        importMenu.delegate = self
        
        //        if Helper.isDeviceiPad() {
        //
        //            if let popoverController = importMenu.popoverPresentationController {
        //                popoverController.sourceView = sender
        //            }
        //        }
        
        
        self.present(importMenu, animated: true, completion: nil)
    }
    
    func openGalleryImagePicker() {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.modalPresentationStyle = .fullScreen
        self.present(picker, animated: true)
    }
    
    func openCameraImagePicker() {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .camera
        picker.modalPresentationStyle = .fullScreen
        self.present(picker, animated: true)
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [AnyHashable: Any]!) {
        //        imageProfile.contentMode = .scaleAspectFit
        print("image: \(image)")
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //        let assetPath = info[UIImagePickerControllerReferenceURL] as! URL
        //        let imgName = assetPath.lastPathComponent
        
        if #available(iOS 11.0, *) {
            if let assetPath = info["UIImagePickerControllerImageURL"] as? URL{
                let imgName = assetPath.lastPathComponent
                print(imgName)
                if (assetPath.absoluteString.hasSuffix("jpg")) {
                    print("jpg")
                    if let pickedImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
                        print("image: \(pickedImage)")
                        
                    }
                }else if (assetPath.absoluteString.hasSuffix("jpeg")) {
                    print("jpeg")
                    
                }
                else if (assetPath.absoluteString.hasSuffix("png")) {
                    print("png")
                    
                }
                else if (assetPath.absoluteString.hasSuffix("gif")) {
                    print("gif")
                    
                }
                else {
                    print("Unknown")
                }
                
            }else {
                if let pickedImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
                    //  sendImg.image = pickedImage
                    let imagePath = URL(fileURLWithPath: "")
                    
                }
            }
        } else {
            // Fallback on earlier versions
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}
