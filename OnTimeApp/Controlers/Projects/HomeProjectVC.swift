//
//  HomeProjectVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/15/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit
import SideMenu
class HomeProjectVC: UIViewController {
    
    @IBOutlet weak var  imgProfile: customImageView!{
    didSet{
    imgProfile.layer.cornerRadius =  imgProfile.frame.width / 2
    imgProfile.layer.borderWidth = 1
    //            ProfileImageView.layer.borderColor =  UIColor(red: 0, green: 156, blue: 158, alpha: 1) as! CGColor
    
    imgProfile.clipsToBounds = true
    
    }
    }
    @IBOutlet weak var allC: UIView!
    @IBOutlet weak var revisionC: UIView!
    @IBOutlet weak var contenueC: UIView!
    @IBOutlet weak var doneC: UIView!
    
    @IBOutlet weak var lblDonePro: UILabel!
    @IBOutlet weak var lblContinuePro: UILabel!
    @IBOutlet weak var lblRevisedPro: UILabel!
    @IBOutlet weak var lblAllPro: UILabel!
    override func viewDidLoad() {
       
      //setupSideMenu()
       
        super.viewDidLoad()

        allC.isHidden = false
        revisionC.isHidden = true
        contenueC.isHidden = true
        doneC.isHidden = true
        
        lblAllPro.textColor = UIColor.hexColor(string: "55DBA8")
        lblDonePro.textColor = UIColor.black
        lblRevisedPro.textColor = UIColor.black
        lblContinuePro.textColor = UIColor.black
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSideMenue(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Projects", bundle: nil)
        let cont = storyboard.instantiateViewController(withIdentifier: "RightMenuNavigationController")
        cont.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        cont.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        self.present(cont, animated: true, completion: nil)
    }
    
    
    @IBAction func btnAllPro(_ sender: Any) {
        allC.isHidden = false
        revisionC.isHidden = true
        contenueC.isHidden = true
        doneC.isHidden = true
        
        lblAllPro.textColor = UIColor.hexColor(string: "55DBA8")
        lblDonePro.textColor = UIColor.black
        lblRevisedPro.textColor = UIColor.black
        lblContinuePro.textColor = UIColor.black
    }
    @IBAction func btnContinuePro(_ sender: Any) {
        allC.isHidden = true
        revisionC.isHidden = true
        contenueC.isHidden = false
        doneC.isHidden = true
        
        lblAllPro.textColor = UIColor.black
        lblDonePro.textColor = UIColor.black
        lblRevisedPro.textColor = UIColor.black
        lblContinuePro.textColor = UIColor.hexColor(string: "55DBA8")
    }
    @IBAction func btnDonePro(_ sender: Any) {
        allC.isHidden = true
        revisionC.isHidden = true
        contenueC.isHidden = true
        doneC.isHidden = false
        
        lblAllPro.textColor = UIColor.black
        lblDonePro.textColor = UIColor.hexColor(string: "55DBA8")

        lblRevisedPro.textColor = UIColor.black
        lblContinuePro.textColor = UIColor.black    }
    
    @IBAction func btnRevisPro(_ sender: Any) {
        allC.isHidden = true
        revisionC.isHidden = false
        contenueC.isHidden = true
        doneC.isHidden = true
        
        lblAllPro.textColor = UIColor.black
        lblDonePro.textColor = UIColor.black
        
        lblRevisedPro.textColor = UIColor.hexColor(string: "55DBA8")
        lblContinuePro.textColor = UIColor.black
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

}
