//
//  moreVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/23/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit
import SwiftyJSON
class moreVC: UIViewController ,UITableViewDataSource , UITableViewDelegate {

    @IBOutlet weak var lblProfileName: UILabel!
    @IBOutlet weak var imgProfile: customImageView!{
    didSet{
    imgProfile.layer.cornerRadius =  imgProfile.frame.width / 2
    imgProfile.layer.borderWidth = 1
    //            ProfileImageView.layer.borderColor =  UIColor(red: 0, green: 156, blue: 158, alpha: 1) as! CGColor
    
    imgProfile.clipsToBounds = true
    
    }
    }
    var arrylabel = [AppCommon.sharedInstance.localization("Projects"),
         AppCommon.sharedInstance.localization("Notification"),
         AppCommon.sharedInstance.localization("Profile"),
         AppCommon.sharedInstance.localization("Our Products"),
         AppCommon.sharedInstance.localization("About US"),
         AppCommon.sharedInstance.localization("Terms & Conditions"),
         AppCommon.sharedInstance.localization("Help"),
         AppCommon.sharedInstance.localization("Change Language")
    ]
//        "المشاريع",
//        "الاشعارات",
//        "الملف الشخصي",
//        "اعمالنا",
//        "من نحن",
//        "الشروط والاحكام",
//        "المساعده",
//        "تغيير اللغة"]
//
    var arryimag = ["briefcase-2","notification-1","Mask Group 2-1","computer-graphic","info-sign-1","question (1)-1","phone-call-small" , "translation"]
    @IBOutlet weak var tblMore: UITableView!
    @IBOutlet weak var lblToday: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        tblMore.delegate = self
        tblMore.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        let result = formatter.string(from: date)
        lblToday.text = result
        imgProfile.loadimageUsingUrlString(url: AppCommon.sharedInstance.getJSON("Profiledata")["img"].stringValue)
        lblProfileName.text = AppCommon.sharedInstance.getJSON("Profiledata")["name"].stringValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrylabel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moreTC", for: indexPath) as! moreTC
        cell.lblName.text = arrylabel[indexPath.row]
        cell.img.image = UIImage(named: arryimag[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Projects", bundle:nil)
            let cont = storyBoard.instantiateViewController(withIdentifier: "HomeNAV")
            self.revealViewController()?.pushFrontViewController(cont, animated: true)
        }

        else if indexPath.row == 1{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Projects", bundle:nil)
            let cont = storyBoard.instantiateViewController(withIdentifier: "NotificationNAV")
            self.revealViewController()?.pushFrontViewController(cont, animated: true)
        }
        else if indexPath.row == 2{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Projects", bundle:nil)
            let cont = storyBoard.instantiateViewController(withIdentifier: "ProfileNAV")
            self.revealViewController()?.pushFrontViewController(cont, animated: true)
        }
            
        else if indexPath.row == 3{
            guard let url = URL(string: "https://www.ontime.sa") else { return }
            UIApplication.shared.open(url)
        }
            
        else if indexPath.row == 4{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Help", bundle:nil)
            let cont = storyBoard.instantiateViewController(withIdentifier: "AboutUsNAV")
            self.revealViewController()?.pushFrontViewController(cont, animated: true)
        }
        else if indexPath.row == 5{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Profile", bundle:nil)
            let cont = storyBoard.instantiateViewController(withIdentifier: "TermsNAV")
            isSideMenueTerms = true
            self.revealViewController()?.pushFrontViewController(cont, animated: true)
        }
        else if indexPath.row == 6{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Help", bundle:nil)
            let cont = storyBoard.instantiateViewController(withIdentifier: "HelpNAV")
            isSideMenueHelp = true
            self.revealViewController()?.pushFrontViewController(cont, animated: true)
        }else if indexPath.row == 7{
            changeLanguage()
        }
        
    }
    
    @IBAction func btnLogout(_ sender: Any) {
        let dialogMessage = UIAlertController(title: AppCommon.sharedInstance.localization("CONFIRM"), message: AppCommon.sharedInstance.localization("Are you sure you want to logout?"), preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: AppCommon.sharedInstance.localization("OK"), style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
            self.Logout()
            AppCommon.sharedInstance.showlogin(vc: self)
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: AppCommon.sharedInstance.localization("cancel"), style: .cancel) { (action) -> Void in
            dialogMessage.dismiss(animated: false, completion: nil)
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    func Logout() {
//        let AccessToken = UserDefaults.standard.string(forKey: "access_token")!
//        let token_type = UserDefaults.standard.string(forKey: "token_type")!
//
//
//        let headers = [
//            "Authorization" : "\(token_type) \(AccessToken)",
//            "lang":SharedData.SharedInstans.getLanguage()
//        ]
//        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
//        http.requestWithBody(url: "\(APIConstants.logout)?device_id=\(DeviceID)", method: .post, tag: 1, header: headers)
        UserDefaults.standard.removeObject(forKey: "Profiledata")
        SharedData.SharedInstans.SetIsLogin(false)
        //Loader.showSuccess(message: message.stringValue)
    }
    
    func changeLanguage() {
        AppCommon.sharedInstance.alertWith(title: AppCommon.sharedInstance.localization("changeLanguage"), message: AppCommon.sharedInstance.localization("changeLanguageMessage"), controller: self, actionTitle: AppCommon.sharedInstance.localization("change"), actionStyle: .default, withCancelAction: true) {
            
            if  SharedData.SharedInstans.getLanguage() == "en" {
                L102Language.setAppleLAnguageTo(lang: "ar")
                SharedData.SharedInstans.setLanguage("ar")
                
            } else if SharedData.SharedInstans.getLanguage() == "ar" {
                L102Language.setAppleLAnguageTo(lang: "en")
                SharedData.SharedInstans.setLanguage("en")
                
            }
            UIView.appearance().semanticContentAttribute = SharedData.SharedInstans.getLanguage() == "en" ? .forceLeftToRight : .forceRightToLeft
            
            let delegate = UIApplication.shared.delegate as! AppDelegate
            //  let storyboard = UIStoryboard(name: "StoryBord", bundle: nil)
            let storyboard = UIStoryboard.init(name: "Projects", bundle: nil);


            delegate.window?.rootViewController = storyboard.instantiateInitialViewController()
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
// constants
let APPLE_LANGUAGE_KEY = "AppleLanguages"
/// L102Language
class L102Language {
    /// get current Apple language
    class func currentAppleLanguage() -> String{
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        return current
    }
    /// set @lang to be the first in Applelanguages list
    class func setAppleLAnguageTo(lang: String) {
        let userdef = UserDefaults.standard
        userdef.set([lang,currentAppleLanguage()], forKey: APPLE_LANGUAGE_KEY)
        userdef.synchronize()
    }
}
