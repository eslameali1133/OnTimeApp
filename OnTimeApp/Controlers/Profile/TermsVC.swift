//
//  TermsVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/28/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit
import SwiftyJSON
var isSideMenueTerms = false
class TermsVC: UIViewController {
    @IBOutlet weak var txtTerms: UITextView!
    @IBOutlet weak var btnArrow: UIButton!
    @IBOutlet weak var bttnArrow: UIBarButtonItem!
    var flag = 1
    var http = HttpHelper()
    @IBOutlet weak var btnSideMenue: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        http.delegate = self
        GetTerms()
        if isSideMenueTerms == true {
            btnArrow.isHidden = true
            isSideMenueTerms = false
        }
        
        if  SharedData.SharedInstans.getLanguage() != "en" {
            btnSideMenue.image = UIImage(named: "arrow-in-circle-point-to-up")
            bttnArrow.image = UIImage(named: "Group 1")
        }
        
        sideMenue()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DINNextLTW23-Regular", size: 20.0)!]

//setupSideMenu()
        // Do any additional setup after loading the view.
    }
    
   
    @IBAction func btnSideMenue(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Projects", bundle: nil)
        let cont = storyboard.instantiateViewController(withIdentifier: "RightMenuNavigationController")
        cont.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        cont.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        self.present(cont, animated: true, completion: nil)
    }
    @IBAction func btnArrow(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func DismissView(_ sender: Any) {
        
            let storyBoard : UIStoryboard = UIStoryboard(name: "Projects", bundle:nil)
            let cont = storyBoard.instantiateViewController(withIdentifier: "HomeNAV")
            self.revealViewController()?.pushFrontViewController(cont, animated: true)
            
       
    }

    func GetTerms(){
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        
        http.GetWithoutHeader(url: APIConstants.Terms, parameters:[:], Tag: 2)
    }
    ////Side Menu
    
    func sideMenue(){
        
        if  SharedData.SharedInstans.getLanguage() == "en" {
            if revealViewController() != nil {
                btnSideMenue.target = revealViewController()
                
                btnSideMenue.action = #selector(SWRevealViewController.rightRevealToggle(_:))
                revealViewController()?.rightViewRevealWidth =  view.frame.width * 0.75
                revealViewController()?.rearViewRevealWidth = view.frame.width * 0.25
                view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
            }
        }else{
            if revealViewController() != nil {
                bttnArrow.target = revealViewController()
                
                bttnArrow.action = #selector(SWRevealViewController.lefttRevealToggle(_:))
                revealViewController()?.rightViewRevealWidth =  view.frame.width * 0.75
                revealViewController()?.rearViewRevealWidth = view.frame.width * 0.25
                view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
                
            }
        }
    }
    
}
extension TermsVC: HttpHelperDelegate {
    func receivedResponse(dictResponse: Any, Tag: Int) {
        print(dictResponse)
        AppCommon.sharedInstance.dismissLoader(self.view)
        
        let json = JSON(dictResponse)
        if Tag == 2 {
            
            let status =  json["status"]
            let Message = json["msg"]
            let data = json["data"]
            if status.stringValue  == "0" {
                
                txtTerms.text = "\(data["terms"].stringValue)"
                
            }
            else {
                Loader.showError(message: Message.stringValue)
            }
            
        }
        
    }
    
    
    func receivedErrorWithStatusCode(statusCode: Int) {
        print(statusCode)
        AppCommon.sharedInstance.alert(title: "Error", message: "\(statusCode)", controller: self, actionTitle: AppCommon.sharedInstance.localization("ok"), actionStyle: .default)
        
        AppCommon.sharedInstance.dismissLoader(self.view)
    }
    
    func retryResponse(numberOfrequest: Int) {
        
    }
    
    
}

