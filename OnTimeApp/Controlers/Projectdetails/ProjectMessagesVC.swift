//
//  ProjectMessagesVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/28/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit

class ProjectMessagesVC: UIViewController {

    @IBOutlet var popupContractor: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

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
        let cont = storyboard.instantiateViewController(withIdentifier: "HelpTopicsVC")
        
        self.present(cont, animated: true, completion: nil)
    }
    @IBAction func btnPayment(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Paid", bundle: nil)
        let cont = storyboard.instantiateViewController(withIdentifier: "PaymentVC")
        
        self.present(cont, animated: true, completion: nil)
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
    @IBAction func DismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
