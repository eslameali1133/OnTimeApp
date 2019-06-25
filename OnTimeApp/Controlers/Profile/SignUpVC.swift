//
//  SignUpVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/13/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource {

    var policyChecked = false
    var invoicChecked = false

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
    
    @IBAction func DismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
