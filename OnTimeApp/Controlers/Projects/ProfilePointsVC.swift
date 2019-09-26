//
//  ProfilePointsVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/28/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit
import SideMenu
import SwiftyJSON
class ProfilePointsVC: UIViewController {

    var Badges = [BadgesModelClass]()
    var ProfileData : ProfileModelClass!
    var http = HttpHelper()
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnSideMenue: UIBarButtonItem!
    @IBOutlet weak var bttnArrow: UIBarButtonItem!
    @IBOutlet weak var lblPointPercentage: UILabel!
    @IBOutlet weak var lblProjects: UILabel!
    @IBOutlet weak var lblPaid: UILabel!
    @IBOutlet weak var lblPoints: UILabel!
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
       // SetData()
        
        if  SharedData.SharedInstans.getLanguage() != "en" {
            btnSideMenue.image = UIImage(named: "arrow-in-circle-point-to-up")
            bttnArrow.image = UIImage(named: "Group 1")
        }
        
        let attributes = [NSAttributedString.Key.font: UIFont(name: "DINNextLTW23-Regular", size: 20)!]
        UINavigationBar.appearance().titleTextAttributes = attributes
        http.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        GetProfileData()
    }
    @IBAction func btnEdit(_ sender: Any) {
        Edit()
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

    func GetProfileData(){
    
        let AccessToken = AppCommon.sharedInstance.getJSON("Profiledata")["token"].stringValue
        print(AccessToken)
        let params = ["token": AccessToken] as [String: Any]
        let headers = [
            "Authorization": AccessToken]
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.GetUserProfile, method: .post, parameters: params, tag: 1, header: headers)
    }
    
    func Edit(){
        let storyboard = UIStoryboard(name: "Projects", bundle: nil)
        let cont = storyboard.instantiateViewController(withIdentifier: "Profile") as! Profile
        cont.ProfileData = ProfileData
        self.present(cont, animated: true, completion: nil)
    }
    
    func SetData(){
    
        lblName.text = ProfileData._name
        lblPhone.text = ProfileData._phone
    imgProfile.loadimageUsingUrlString(url:ProfileData._img)
        lblPaid.text = ProfileData._total_paid
        lblPoints.text = ProfileData._points
        lblProjects.text = ProfileData._projects
        lblPointPercentage.text = "\(ProfileData._points) نقطة"
        
    }
    
    @IBAction func DismissView(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Projects", bundle:nil)
        let cont = storyBoard.instantiateViewController(withIdentifier: "HomeNAV")
        self.revealViewController()?.pushFrontViewController(cont, animated: true)
    }

}

extension ProfilePointsVC : HttpHelperDelegate {
    func receivedResponse(dictResponse: Any, Tag: Int) {
        print(dictResponse)
        AppCommon.sharedInstance.dismissLoader(self.view)
        let json = JSON(dictResponse)
        if Tag == 1 {
            let status =  json["status"]
            let data = json["data"]
            let message = json["msg"]
            let JBadges = json["badges"].arrayValue
            if status.stringValue == "0" {
                
                for json in JBadges{
                    let obj = BadgesModelClass(
                        id: json["id"].stringValue,
                        title: json["title"].stringValue,
                        img: json["img"].stringValue
                    )
                    Badges.append(obj)
                }
                ProfileData = ProfileModelClass(
                    id: data["id"].stringValue,
                    name: data["name"].stringValue,
                    user_type: data["user_type"].stringValue,
                    phone: data["phone"].stringValue,
                    email: data["email"].stringValue,
                    company_name: data["company_name"].stringValue,
                    percentage: data["percentage"].stringValue,
                    points: data["points"].stringValue,
                    total_paid: data["total_paid"].stringValue,
                    projects: data["projects"].stringValue,
                    img: data["img"].stringValue
                )
                self.SetData()
                 AppCommon.sharedInstance.dismissLoader(self.view)
                
                
            } else {
                Loader.showError(message: message.stringValue )
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

