//
//  VerifyProjectRequest.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/28/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit

class VerifyProjectRequest: UIViewController {
var policiesChecked = false
    @IBOutlet weak var imgPolicies: UIImageView!
    @IBOutlet var popupRequest: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        popupRequest.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(popupRequest)
        popupRequest.isHidden = true
        
        // Do any additional setup after loading the view.
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

    @IBAction func btnPoliciess(_ sender: Any) {
        if policiesChecked == false {
            imgPolicies.image = UIImage(named: "check")
            policiesChecked = true
        }else{
            imgPolicies.image = UIImage(named: "check (1)")
            policiesChecked = false
        }
    }
    @IBAction func btnVerify(_ sender: Any) {
        popupRequest.isHidden = false
        popupRequest.backgroundColor = UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.75)
    }
}
