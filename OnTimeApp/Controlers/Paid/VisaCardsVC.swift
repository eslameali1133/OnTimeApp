//
//  VisaCardsVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/28/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit

class VisaCardsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnPay(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ProjectDetails", bundle: nil)
        let cont = storyboard.instantiateViewController(withIdentifier: "ProjectMessagesVC")
        
        self.present(cont, animated: true, completion: nil)
    }
    @IBAction func DismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
