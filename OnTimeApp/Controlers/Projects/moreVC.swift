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
        "المساعده"]
        
    var arryimag = ["briefcase-2","notification-1","Mask Group 2-1","computer-graphic","info-sign-1","question (1)-1","phone-call-small"]
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
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
