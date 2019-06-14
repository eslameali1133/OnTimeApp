//
//  AaqdInfoVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/28/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit

class AaqdInfoVC: UIViewController {
var imgChecked1 = false
    var imgChecked2 = false
    @IBOutlet weak var imgScinario: UIImageView!
    @IBOutlet weak var imgQuickService: UIImageView!
    @IBOutlet var popupPolecies: UIView!
    @IBOutlet var popupprojectDetails: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

         popupPolecies.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(popupPolecies)
        popupPolecies.isHidden = true
        
        popupprojectDetails.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(popupprojectDetails)
        popupprojectDetails.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnPolecies(_ sender: Any) {
        popupPolecies.isHidden = false
        popupPolecies.backgroundColor = UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.75)
    }
    
    @IBAction func btnHideProjectDetails(_ sender: Any) {
        popupprojectDetails.isHidden = true
    }
    @IBAction func btnHidePolicies(_ sender: Any) {
        popupPolecies.isHidden = true
    }
    @IBAction func btnQuickService(_ sender: Any) {
        if imgChecked1 == false {
            imgQuickService.image = UIImage(named: "check")
            imgChecked1 = true
        }else{
            imgQuickService.image = UIImage(named: "check (1)")
            imgChecked1 = false
        }
    }
    @IBAction func btnScinario(_ sender: Any) {
        if imgChecked2 == false {
            imgScinario.image = UIImage(named: "check")
            imgChecked2 = true
        }else{
            imgScinario.image = UIImage(named: "check (1)")
            imgChecked2 = false
        }
    }
    @IBAction func btnShowDetails(_ sender: Any) {
       
        popupprojectDetails.isHidden = false; popupprojectDetails.backgroundColor = UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.75)
    }
    @IBAction func DismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
