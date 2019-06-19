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
setupSideMenu()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        setupSideMenu()
    }
    @IBAction func btnSideMenue(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Projects", bundle: nil)
        let cont = storyboard.instantiateViewController(withIdentifier: "RightMenuNavigationController")
        cont.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        cont.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        self.present(cont, animated: true, completion: nil)
    }

    ////Side Menu
    
    fileprivate func setupSideMenu() {
        //        if SharedData.SharedInstans.getLanguage() == "en"
        //        {
        //            // Define the menus
        //
        //            RigthMenubtn.title = " "
        //            RigthMenubtn.image = nil
        //            RigthMenubtn.isEnabled  = false
        //
        //            RigthMenubtn.width = 0.00000000001;
        //            LeftMenuBtn.width = 0;
        //
        //            SideMenuManager.default.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
        //            SideMenuManager.default.menuLeftNavigationController?.leftSide = true
        //
        //
        //
        //
        //
        //        }else
        //        {
        //
        //             Define the menus
        SideMenuManager.default.menuRightNavigationController = storyboard!.instantiateViewController(withIdentifier: "RightMenuNavigationController") as? UISideMenuNavigationController
        SideMenuManager.default.menuLeftNavigationController?.leftSide = false
        //}
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        SideMenuManager.default.menuAddPanGestureToPresent(toView:self.view)
        //self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.view)
        //self.navigationController!.view)
        SideMenuManager.default.menuWidth = view.frame.width * 0.75
        // Set up a cool background image for demo purposes
        //        SideMenuManager.default.menuAnimationBackgroundColor = UIColor(patternImage: UIImage(named: "background")!)
    }
    @IBAction func DismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
