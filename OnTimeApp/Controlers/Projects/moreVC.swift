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
    var arrylabel = [
        "المشاريع",
        "الاشعارات",
        "الملف الشخصي",
        "اعمالنا",
        "من نحن",
        "الشروط والاحكام",
        "المساعده",
        "الخروج"]
        
    var arryimag = ["briefcase-2","notification-1","Mask Group 2-1","computer-graphic","info-sign-1","question (1)-1","phone-call-small" , "phone-call-small"]
    @IBOutlet weak var tblMore: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        lblProfileName.text = "\(AppCommon.sharedInstance.getJSON("Profiledata")["name"].stringValue))"
        tblMore.delegate = self
        tblMore.dataSource = self
        // Do any additional setup after loading the view.
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
        }
        else if indexPath.row == 7{
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
