//
//  Introduction2VC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/28/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit

class Introduction2VC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSkip(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Profile", bundle:nil)
        let cont = storyBoard.instantiateViewController(withIdentifier: "LoginVC")as! LoginVC
        self.present(cont, animated: true, completion: nil)
    }

}
