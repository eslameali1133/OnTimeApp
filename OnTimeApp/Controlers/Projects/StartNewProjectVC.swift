//
//  StartNewProjectVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/28/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit

class StartNewProjectVC: UIViewController {

    @IBOutlet weak var lblProfileName: UILabel!
    @IBOutlet weak var imgPro:  customImageView!
//        {
//    didSet{
//    imgPro.layer.cornerRadius =  imgPro.frame.width / 2
//    imgPro.layer.borderWidth = 1
//    //            ProfileImageView.layer.borderColor =  UIColor(red: 0, green: 156, blue: 158, alpha: 1) as! CGColor
//    
//    imgPro.clipsToBounds = true
//    
//    }
//    }
    @IBOutlet weak var  imgProfile: customImageView!{
    didSet{
    imgProfile.layer.cornerRadius =  imgProfile.frame.width / 2
    imgProfile.layer.borderWidth = 1
    //            ProfileImageView.layer.borderColor =  UIColor(red: 0, green: 156, blue: 158, alpha: 1) as! CGColor
    
    imgProfile.clipsToBounds = true
    
    }
    }
    @IBOutlet weak var lblToday: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        let result = formatter.string(from: date)
        lblToday.text = result
        
        imgProfile.loadimageUsingUrlString(url: AppCommon.sharedInstance.getJSON("Profiledata")["img"].stringValue)
        lblProfileName.text = AppCommon.sharedInstance.getJSON("Profiledata")["name"].stringValue
        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func btnSideMenue(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Projects", bundle: nil)
        let cont = storyboard.instantiateViewController(withIdentifier: "RightMenuNavigationController")
        cont.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        cont.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        self.present(cont, animated: true, completion: nil)
    }
    @IBAction func DismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
