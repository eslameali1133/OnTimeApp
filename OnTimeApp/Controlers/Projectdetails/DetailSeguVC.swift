//
//  DetailSeguVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/29/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit

class DetailSeguVC: UIViewController {

    @IBOutlet weak var invoiceC: UIView!
    @IBOutlet weak var oqoodC: UIView!
    @IBOutlet weak var attachC: UIView!
    
    @IBOutlet weak var infoC: UIView!
    @IBOutlet weak var invoiceV: UIView!
    @IBOutlet weak var oqoodV: UIView!
    @IBOutlet weak var attachV: UIView!
    @IBOutlet weak var infoV: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        infoC.isHidden = false
        attachC.isHidden = true
        oqoodC.isHidden = true
        invoiceC.isHidden = true
        
        infoV.backgroundColor = UIColor.hexColor(string: "99DB90")
        attachV.backgroundColor = UIColor.white
        oqoodV.backgroundColor = UIColor.white
        invoiceV.backgroundColor = UIColor.white
        
        
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnSideMenu(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Projects", bundle: nil)
        let cont = storyboard.instantiateViewController(withIdentifier: "RightMenuNavigationController")
        cont.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        cont.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        self.present(cont, animated: true, completion: nil)
    }
    @IBAction func Info(_ sender: Any) {
        infoC.isHidden = false
        attachC.isHidden = true
        oqoodC.isHidden = true
        invoiceC.isHidden = true
        
        infoV.backgroundColor = UIColor.hexColor(string: "99DB90")
        attachV.backgroundColor = UIColor.white
        oqoodV.backgroundColor = UIColor.white
        invoiceV.backgroundColor = UIColor.white
    }
    
    @IBAction func Attach(_ sender: Any) {
        infoC.isHidden = true
        attachC.isHidden = false
        oqoodC.isHidden = true
        invoiceC.isHidden = true
        
        infoV.backgroundColor = UIColor.white
        attachV.backgroundColor = UIColor.hexColor(string: "99DB90")
        oqoodV.backgroundColor = UIColor.white
        invoiceV.backgroundColor = UIColor.white
    }
    @IBAction func DismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func Oqood(_ sender: Any) {
        infoC.isHidden = true
        attachC.isHidden = true
        oqoodC.isHidden = false
        invoiceC.isHidden = true
        
        infoV.backgroundColor = UIColor.white
        attachV.backgroundColor = UIColor.white
        oqoodV.backgroundColor = UIColor.hexColor(string: "99DB90")
        invoiceV.backgroundColor = UIColor.white
    }
    @IBAction func Invoice(_ sender: Any) {
        infoC.isHidden = true
        attachC.isHidden = true
        oqoodC.isHidden = true
        invoiceC.isHidden = false
        
        infoV.backgroundColor = UIColor.white
        attachV.backgroundColor = UIColor.white
        oqoodV.backgroundColor = UIColor.white
        invoiceV.backgroundColor = UIColor.hexColor(string: "99DB90")
    }
}
