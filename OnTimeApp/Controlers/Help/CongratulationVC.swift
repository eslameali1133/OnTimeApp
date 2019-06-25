//
//  CongratulationVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/28/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit

class CongratulationVC: UIViewController {
var documentInteractionController = UIDocumentInteractionController()
    @IBOutlet weak var RatingControl: RatingControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnDownload(_ sender: Any) {
        let url = URL(string: "http://www.mywebsite.com/myfile.pdf")
        documentInteractionController.url = url
        documentInteractionController.uti = url!.typeIdentifier ?? "public.data, public.content"
        documentInteractionController.name = url!.localizedName ?? url!.lastPathComponent
        documentInteractionController.presentOptionsMenu(from: view.frame, in: view, animated: true)
    }
    @IBAction func btnShare(_ sender: Any) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let textToShare = "Check OnTime app"
        
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
    @IBAction func btnSend(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Projects", bundle: nil)
        let cont = storyboard.instantiateViewController(withIdentifier: "Home")
        
        self.present(cont, animated: true, completion: nil)
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

extension URL {
    var typeIdentifier: String? {
        return (try? resourceValues(forKeys: [.typeIdentifierKey]))?.typeIdentifier
    }
    var localizedName: String? {
        return (try? resourceValues(forKeys: [.localizedNameKey]))?.localizedName
    }
}

