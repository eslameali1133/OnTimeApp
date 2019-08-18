//
//  AloqoodVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/16/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit

class AloqoodVC: UIViewController , UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var tblAqood: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tblAqood.delegate = self
        tblAqood.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnDownload(_ sender: Any) {
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
        }}
    @IBAction func DismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GRequestDetail._contracts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AloqoodTC", for: indexPath) as! AloqoodTC
        cell.lblName.text = GRequestDetail._contracts[indexPath.row]._name
        cell.pdf = GRequestDetail._contracts[indexPath.row]._pdf
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
