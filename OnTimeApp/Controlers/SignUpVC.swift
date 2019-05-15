//
//  SignUpVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/13/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var btnSignUp: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        btnSignUp.layer.cornerRadius = 20
        btnSignUp.layer.borderWidth = 1
        btnSignUp.layer.borderColor = UIColor.white.cgColor
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
