//
//  AttachmentVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/16/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit

class AttachmentVC: UIViewController , UITableViewDataSource , UITableViewDelegate{

   
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet var popupSocial: UIView!
    @IBOutlet weak var tblAttachment: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

         popupSocial.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(popupSocial)
        popupSocial.isHidden = true
                tblAttachment.delegate = self
        tblAttachment.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnDownload(_ sender: Any) {
    }
    @IBAction func btnHidePopupSocial(_ sender: Any) {
        popupSocial.isHidden = true
    }
    @IBAction func btnShare(_ sender: Any) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let textToShare = "Check Taqseema app"
        
        if let myWebsite = URL(string: "http://itunes.apple.com/app/id1451620043") {//Enter link to your app here
            let objectsToShare = [textToShare, myWebsite, image ?? #imageLiteral(resourceName: "ic_launcher")] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            //Excluded Activities
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.postToFacebook, UIActivity.ActivityType.addToReadingList]
            //
            
            activityVC.popoverPresentationController?.sourceView = self.view
            self.present(activityVC, animated: true, completion: nil)
        }
        
    }
    @IBAction func btnHideSocial(_ sender: Any) {
        popupSocial.isHidden = true
    }
    @IBAction func btnSocial(_ sender: Any) {
        popupSocial.isHidden = false
        popupSocial.backgroundColor = UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.75)

    }
    @IBAction func DismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttachmentTC", for: indexPath) as! AttachmentTC
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
