//
//  HelpMethodVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/28/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit
import SideMenu
var isSideMenueHelp = false
class HelpMethodVC: UIViewController {
    @IBOutlet weak var btnArrow: UIButton!
    @IBOutlet weak var btnSideMenue: UIBarButtonItem!
    override func viewDidLoad() {
         super.viewDidLoad()
        if isSideMenueHelp == true{
            btnArrow.isHidden = true
            isSideMenueHelp = false
        }
        sideMenue()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DINNextLTW23-Regular", size: 20.0)!]
//setupSideMenu()
        // Do any additional setup after loading the view.
    }
   

    @IBAction func btnArrow(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnSideMenue(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Projects", bundle: nil)
        let cont = storyboard.instantiateViewController(withIdentifier: "RightMenuNavigationController")
        cont.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        cont.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        self.present(cont, animated: true, completion: nil)
    }
    
    func sideMenue(){
        if revealViewController() != nil {
            btnSideMenue.target = revealViewController()
            btnSideMenue.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            revealViewController()?.rightViewRevealWidth =  view.frame.width * 0.75
            revealViewController()?.rearViewRevealWidth = view.frame.width * 0.25
            view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        }
    }

    
 @IBAction func DismissView(_ sender: Any) {
    
    let storyBoard : UIStoryboard = UIStoryboard(name: "Projects", bundle:nil)
    let cont = storyBoard.instantiateViewController(withIdentifier: "HomeNAV")
    self.revealViewController()?.pushFrontViewController(cont, animated: true)
    
 }

}
