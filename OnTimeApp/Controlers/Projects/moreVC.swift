//
//  moreVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/23/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit

class moreVC: UIViewController ,UITableViewDataSource , UITableViewDelegate {

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
            let cont = storyBoard.instantiateViewController(withIdentifier: "HomeProjectVC")as! HomeProjectVC
            self.present(cont, animated: true, completion: nil)
        }

        else if indexPath.row == 1{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Projects", bundle:nil)
            let cont = storyBoard.instantiateViewController(withIdentifier: "NotificationVC")as! NotificationVC
            self.present(cont, animated: true, completion: nil)
        }
        else if indexPath.row == 2{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Projects", bundle:nil)
            let cont = storyBoard.instantiateViewController(withIdentifier: "ProfilePointsVC")as! ProfilePointsVC
            self.present(cont, animated: true, completion: nil)
        }
        else if indexPath.row == 4{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Help", bundle:nil)
            let cont = storyBoard.instantiateViewController(withIdentifier: "OnTimeVC")as! OnTimeVC
            self.present(cont, animated: true, completion: nil)
        }
        else if indexPath.row == 5{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Profile", bundle:nil)
            let cont = storyBoard.instantiateViewController(withIdentifier: "TermsVC")as! TermsVC
            self.present(cont, animated: true, completion: nil)
        }
        else if indexPath.row == 6{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Help", bundle:nil)
            let cont = storyBoard.instantiateViewController(withIdentifier: "HelpMethodVC")as! HelpMethodVC
            self.present(cont, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
