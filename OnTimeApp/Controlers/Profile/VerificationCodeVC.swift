//
//  VerificationCodeVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/12/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit

class VerificationCodeVC: UIViewController {

    @IBOutlet var popupVerefy: UIView!
    @IBOutlet weak var txtCode: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        popupVerefy.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(popupVerefy)
        popupVerefy.isHidden = true
       // btnSend.backgroundColor = .clear
        btnSend.layer.cornerRadius = 30
        btnSend.layer.borderWidth = 1
        btnSend.layer.borderColor = UIColor.white.cgColor
    
   

        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnSend(_ sender: Any) {
        popupVerefy.isHidden = false
        popupVerefy.backgroundColor = UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.75)
    }
    

}
