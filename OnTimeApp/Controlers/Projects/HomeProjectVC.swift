//
//  HomeProjectVC.swift
//  OnTimeApp
//  Created by Husseinomda16 on 5/15/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit
import SideMenu

class HomeProjectVC: UIViewController {
    
    @IBOutlet weak var lblDonecount: UILabel!
    @IBOutlet weak var lblContinucount: UILabel!
    @IBOutlet weak var lblRivscount: UILabel!
    @IBOutlet weak var lblAllcount: UILabel!
    @IBOutlet weak var lblProfileName: UILabel!
    @IBOutlet weak var btnSideMenue: UIBarButtonItem!
    @IBOutlet weak var  imgProfile: customImageView!{
    didSet{
    imgProfile.layer.cornerRadius =  imgProfile.frame.width / 2
    imgProfile.layer.borderWidth = 1
    //            ProfileImageView.layer.borderColor =  UIColor(red: 0, green: 156, blue: 158, alpha: 1) as! CGColor
    
    imgProfile.clipsToBounds = true
    
    }
    }
    @IBOutlet weak var tabDone: UIView!
    @IBOutlet weak var tabContinue: UIView!
    @IBOutlet weak var tabRevised: UIView!
    @IBOutlet weak var tabAll: UIView!
    @IBOutlet weak var allC: UIView!
    @IBOutlet weak var revisionC: UIView!
    @IBOutlet weak var contenueC: UIView!
    @IBOutlet weak var doneC: UIView!
    
    @IBOutlet weak var lblDonePro: UILabel!
    @IBOutlet weak var lblContinuePro: UILabel!
    @IBOutlet weak var lblRevisedPro: UILabel!
    @IBOutlet weak var lblAllPro: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblProfileName.text = "\(AppCommon.sharedInstance.getJSON("Profiledata")["name"].stringValue))"
        sideMenue()
       // setupSideMenu()
        allC.isHidden = false
        revisionC.isHidden = true
        contenueC.isHidden = true
        doneC.isHidden = true
        tabAll.backgroundColor = UIColor.hexColor(string: "EFEFF4")
//        lblAllPro.textColor = UIColor.hexColor(string: "55DBA8")
//        lblDonePro.textColor = UIColor.black
//        lblRevisedPro.textColor = UIColor.black
//        lblContinuePro.textColor = UIColor.black
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        setcount()
    }
    func setcount(){
        lblAllcount.text = Gallcount
        lblDonecount.text = Gdonecount
        lblContinucount.text = Gcontinucount
        lblRivscount.text = Griviscount
    }
    @IBAction func btnAllPro(_ sender: Any) {
        allC.isHidden = false
        revisionC.isHidden = true
        contenueC.isHidden = true
        doneC.isHidden = true
        
        tabAll.backgroundColor = UIColor.hexColor(string: "EFEFF4")
        tabDone.backgroundColor = UIColor.white
        tabRevised.backgroundColor = UIColor.white
        tabContinue.backgroundColor = UIColor.white
        
//        lblAllPro.textColor = UIColor.hexColor(string: "55DBA8")
//        lblDonePro.textColor = UIColor.black
//        lblRevisedPro.textColor = UIColor.black
//        lblContinuePro.textColor = UIColor.black
    }
    @IBAction func btnContinuePro(_ sender: Any) {
        allC.isHidden = true
        revisionC.isHidden = true
        contenueC.isHidden = false
        doneC.isHidden = true
        
        tabAll.backgroundColor = UIColor.white
        tabDone.backgroundColor = UIColor.white
        tabRevised.backgroundColor = UIColor.white
        tabContinue.backgroundColor = UIColor.hexColor(string: "EFEFF4")
        
//        lblAllPro.textColor = UIColor.black
//        lblDonePro.textColor = UIColor.black
//        lblRevisedPro.textColor = UIColor.black
//        lblContinuePro.textColor = UIColor.hexColor(string: "55DBA8")
    }
    @IBAction func btnDonePro(_ sender: Any) {
        allC.isHidden = true
        revisionC.isHidden = true
        contenueC.isHidden = true
        doneC.isHidden = false
        
        tabAll.backgroundColor = UIColor.white
        tabDone.backgroundColor = UIColor.hexColor(string: "EFEFF4")
        tabRevised.backgroundColor = UIColor.white
        tabContinue.backgroundColor = UIColor.white
        
//        lblAllPro.textColor = UIColor.black
//        lblDonePro.textColor = UIColor.hexColor(string: "55DBA8")
//
//        lblRevisedPro.textColor = UIColor.black
//        lblContinuePro.textColor = UIColor.black
        
    }
    
    @IBAction func btnRevisPro(_ sender: Any) {
        allC.isHidden = true
        revisionC.isHidden = false
        contenueC.isHidden = true
        doneC.isHidden = true
        
        tabAll.backgroundColor = UIColor.white
        tabDone.backgroundColor = UIColor.white
        tabRevised.backgroundColor = UIColor.hexColor(string: "EFEFF4")
        tabContinue.backgroundColor = UIColor.white
        
//        lblAllPro.textColor = UIColor.black
//        lblDonePro.textColor = UIColor.black
//
//        lblRevisedPro.textColor = UIColor.hexColor(string: "55DBA8")
//        lblContinuePro.textColor = UIColor.black
    }
    ////Side Menu

    fileprivate func setupSideMenu() {
        
 SideMenuManager.default.menuRightNavigationController = storyboard!.instantiateViewController(withIdentifier: "RightMenuNavigationController") as? UISideMenuNavigationController
            SideMenuManager.default.menuLeftNavigationController?.leftSide = false
        SideMenuManager.default.menuAddPanGestureToPresent(toView:
            self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView:
            self.navigationController!.view)
        SideMenuManager.default.menuWidth = view.frame.width * 0.75
       
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
   

}

