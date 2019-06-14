//
//  LoginVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/12/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var btnLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        btnLogin.layer.cornerRadius = 30
        btnLogin.layer.borderWidth = 1
        btnLogin.layer.borderColor = UIColor.white.cgColor
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnLogin(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Projects", bundle:nil)
        let cont = storyBoard.instantiateViewController(withIdentifier: "HomeProjectVC")as! HomeProjectVC
        self.present(cont, animated: true, completion: nil)
        
    }
    

}
