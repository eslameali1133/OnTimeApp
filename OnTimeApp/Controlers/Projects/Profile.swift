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
    var policyChecked = false
    var invoicChecked = false
    var AlertController: UIAlertController!
    let imgpicker = UIImagePickerController()
    @IBOutlet weak var lblKey: UILabel!
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
        lblKey.text = "+966"
        // Do any additional setup after loading the view.
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
            invoicChecked = true
        }else{
            chekInvoice.image = UIImage(named: "check (1)")
            invoicChecked = false
        }
    }
    @IBAction func btnOrg(_ sender: Any) {
        imgOrg.image = UIImage(named: "radio-on-button (3)")
        imgPeople.image = UIImage(named: "radio-on-button (4)")
    }
    @IBAction func btnPeople(_ sender: Any) {
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

