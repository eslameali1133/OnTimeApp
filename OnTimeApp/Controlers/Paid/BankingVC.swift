//
//  BankingVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/28/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit

class BankingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DINNextLTW23-Regular", size: 20.0)!]
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnPay(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ProjectDetails", bundle: nil)
        let cont = storyboard.instantiateViewController(withIdentifier: "ProjectMessagesVC")
        
        self.present(cont, animated: true, completion: nil)
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

}
