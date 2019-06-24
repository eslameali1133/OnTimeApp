//
//  ProfilePointsVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/28/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit
import SideMenu
class ProfilePointsVC: UIViewController {

    @IBOutlet weak var btnSideMenue: UIBarButtonItem!
    @IBOutlet weak var imgProfile: customImageView!{
    didSet{
    imgProfile.layer.cornerRadius =  imgProfile.frame.width / 2
    imgProfile.layer.borderWidth = 1
    //            ProfileImageView.layer.borderColor =  UIColor(red: 0, green: 156, blue: 158, alpha: 1) as! CGColor
    
    imgProfile.clipsToBounds = true
    
    }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenue()
        // Do any additional setup after loading the view.
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
