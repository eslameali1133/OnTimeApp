//
//  OnTimeVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/28/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit
import SideMenu
import SwiftyJSON
class OnTimeVC: UIViewController {
    var txtAboutUs = ""
    var txtFacebook = ""
    var txtTwiter = ""
    var txtInstigram = ""
    var http = HttpHelper()
    @IBOutlet weak var btnSideMenue: UIBarButtonItem!
    @IBOutlet weak var bttnArrow: UIBarButtonItem!
    @IBOutlet weak var txtdesc: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        if  SharedData.SharedInstans.getLanguage() != "en" {
            btnSideMenue.image = UIImage(named: "arrow-in-circle-point-to-up")
            bttnArrow.image = UIImage(named: "Group 1")
        }
        
        let attributes = [NSAttributedString.Key.font: UIFont(name: "DINNextLTW23-Regular", size: 20)!]
        UINavigationBar.appearance().titleTextAttributes = attributes
        http.delegate = self
        aboutUs()
        sideMenue()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DINNextLTW23-Regular", size: 20.0)!]
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnFaceBook(_ sender: Any) {
        guard let url = URL(string: txtFacebook) else { return }
        UIApplication.shared.open(url)
    }
    @IBAction func btnInstigram(_ sender: Any) {
        guard let url = URL(string: txtInstigram) else { return }
        UIApplication.shared.open(url)
    }
    @IBAction func btnTwitter(_ sender: Any) {
        guard let url = URL(string: txtTwiter) else { return }
        UIApplication.shared.open(url)
    }
    @IBAction func btnSideMenue(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Projects", bundle: nil)
        let cont = storyboard.instantiateViewController(withIdentifier: "RightMenuNavigationController")
        cont.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        cont.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        self.present(cont, animated: true, completion: nil)
    }
    
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

    
    @IBAction func DismissView(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Projects", bundle:nil)
        let cont = storyBoard.instantiateViewController(withIdentifier: "HomeNAV")
        self.revealViewController()?.pushFrontViewController(cont, animated: true)
    }
    
    func aboutUs(){
    
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        
        http.GetWithoutHeader(url: APIConstants.aboutUs, parameters:[:], Tag: 1)
    }

}
extension OnTimeVC: HttpHelperDelegate {
    func receivedResponse(dictResponse: Any, Tag: Int) {
        print(dictResponse)
        AppCommon.sharedInstance.dismissLoader(self.view)
        
        let json = JSON(dictResponse)
        if Tag == 1 {
            
            let status =  json["status"]
            let Message = json["msg"]
            let data = json["data"]
            if status.stringValue  == "0" {
                txtdesc.text = data["who_we_are"].stringValue
                txtFacebook = data["fb"].stringValue
                txtTwiter = data["tw"].stringValue
                txtInstigram = data["ins"].stringValue
                
            }else if status.stringValue == "500"{
                Loader.showError(message: AppCommon.sharedInstance.localization("Wrong request type"))
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
