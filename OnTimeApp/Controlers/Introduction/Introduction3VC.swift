//
//  Introduction3VC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/28/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit

class Introduction3VC: UIViewController {

    var index = 1
    @IBOutlet weak var container3: UIView!
    @IBOutlet weak var conrainer2: UIView!
    @IBOutlet weak var container1: UIView!
 
    
    @IBOutlet weak var view1: AMCircleUIView!
    @IBOutlet weak var view2: AMCircleUIView!
    @IBOutlet weak var view3: AMCircleUIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        container1.isHidden = false
        conrainer2.isHidden = true
        container3.isHidden = true
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnNext(_ sender: Any) {
        if index == 3{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Profile", bundle:nil)
            let cont = storyBoard.instantiateViewController(withIdentifier: "LoginVC")as! LoginVC
            self.present(cont, animated: true, completion: nil)
        }else{
        index += 1
        tabChanged()
            
        }
    }
    @IBAction func tab1(_ sender: Any) {
        index = 1
        tabChanged()
    }
    @IBAction func tab2(_ sender: Any) {
        index = 2
        tabChanged()
    }
    @IBAction func tab3(_ sender: Any) {
        index = 3
        tabChanged()
    }
    @IBAction func btnLogin(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Projects", bundle:nil)
        let cont = storyBoard.instantiateViewController(withIdentifier: "HomeProjectVC")as! LoginVC
        self.present(cont, animated: true, completion: nil)
    
    }
    
    @IBAction func btnSkip(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Profile", bundle:nil)
        let cont = storyBoard.instantiateViewController(withIdentifier: "LoginVC")as! LoginVC
        self.present(cont, animated: true, completion: nil)
    }
    
    func tabChanged(){
        if index == 1 {
            view1.backgroundColor = UIColor.white
            view2.backgroundColor = UIColor.black
            view3.backgroundColor = UIColor.black
            container1.isHidden = false
            conrainer2.isHidden = true
            container3.isHidden = true
        }
        else if index == 2{
            view1.backgroundColor = UIColor.black
            view2.backgroundColor = UIColor.white
            view3.backgroundColor = UIColor.black
            container1.isHidden = true
            conrainer2.isHidden = false
            container3.isHidden = true
        }
        else if index == 3 {
         
            view1.backgroundColor = UIColor.black
            view2.backgroundColor = UIColor.black
            view3.backgroundColor = UIColor.white
            container1.isHidden = true
            conrainer2.isHidden = true
            container3.isHidden = false
        }
    }
    
}
