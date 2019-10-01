//
//  CongratulationVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/28/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit
import SwiftyJSON
class CongratulationVC: UIViewController {
var documentInteractionController = UIDocumentInteractionController()
    var ProjectURL = ""
    var RequestID = ""
    var http = HttpHelper()
    @IBOutlet weak var RatingControl: RatingControl!
    @IBOutlet weak var btnBack: UIBarButtonItem!
    @IBOutlet weak var txtRate: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if  SharedData.SharedInstans.getLanguage() != "en" {
            btnBack.image = UIImage(named: "arrow-in-circle-point-to-up-1")
        }
        http.delegate = self
        print(ProjectURL)
        
        let attributes = [NSAttributedString.Key.font: UIFont(name: "DINNextLTW23-Regular", size: 20)!]
        UINavigationBar.appearance().titleTextAttributes = attributes
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnDownload(_ sender: Any) {
        let url = URL(string: ProjectURL)
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
        SendRate()
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
    func SendRate(){
        let AccessToken = AppCommon.sharedInstance.getJSON("Profiledata")["token"].stringValue
        print(AccessToken)
        print(GRate)
        let params = ["token": AccessToken,
                      "request_id" : RequestID ,
                      "rate" : GRate ,
                      "comment" : txtRate.text! ,
                      "voice" : ""
            ] as [String: Any]
        let headers = [
            "Authorization": AccessToken]
        //AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.SendRate, method: .post, parameters: params, tag: 1, header: headers)
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
extension CongratulationVC : HttpHelperDelegate {
    func receivedResponse(dictResponse: Any, Tag: Int) {
        print(dictResponse)
        AppCommon.sharedInstance.dismissLoader(self.view)
        let json = JSON(dictResponse)
        if Tag == 1 {
            let status =  json["status"]
            let message = json["msg"]
            
            if status.stringValue == "0" {
                let storyboard = UIStoryboard(name: "Projects", bundle: nil)
                let cont = storyboard.instantiateViewController(withIdentifier: "Home")
                
                self.present(cont, animated: true, completion: nil)
            } else if status.stringValue == "500"{
                Loader.showError(message: AppCommon.sharedInstance.localization("Wrong request type"))
            }else if status.stringValue == "505"{
                Loader.showError(message: AppCommon.sharedInstance.localization("error"))
            }else if status.stringValue == "1"{
                Loader.showError(message: AppCommon.sharedInstance.localization("some missing data"))
            }else if status.stringValue == "204"{
                Loader.showError(message: AppCommon.sharedInstance.localization("un authorized"))
            }else if status.stringValue == "219"{
                Loader.showError(message: AppCommon.sharedInstance.localization("Not finished yet"))
            }else {
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

