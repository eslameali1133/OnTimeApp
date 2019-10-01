//
//  NotificationVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/28/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit
import SideMenu
import SwiftyJSON
class NotificationVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
    var cellSpacingHeight : CGFloat = -15
    var http = HttpHelper()
    var Notifications = [NotificationModelClass]()
    @IBOutlet weak var lblNotificationNum: UILabel!
    @IBOutlet weak var btnSideMenue: UIBarButtonItem!
    @IBOutlet weak var btnBack: UIBarButtonItem!
    @IBOutlet weak var imgAlarm: UIImageView!
    @IBOutlet weak var tblNotification: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        if  SharedData.SharedInstans.getLanguage() != "en" {
            btnSideMenue.image = UIImage(named: "arrow-in-circle-point-to-up")
            btnBack.image = UIImage(named: "Group 1")
        }
        http.delegate = self
        GetNotifications()
        sideMenue()
        tblNotification.delegate = self
        tblNotification.dataSource = self
        
        let attributes = [NSAttributedString.Key.font: UIFont(name: "DINNextLTW23-Regular", size: 20)!]
        UINavigationBar.appearance().titleTextAttributes = attributes
        //self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DINNextLTW23-Regular", size: 20.0)!]
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnReadAll(_ sender: Any) {
        ReadAllNotification()
    }
    @IBAction func btnPayment(_ sender: Any) {
    }
    @IBAction func btnSideMenue(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Projects", bundle: nil)
        let cont = storyboard.instantiateViewController(withIdentifier: "RightMenuNavigationController")
        cont.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        cont.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        self.present(cont, animated: true, completion: nil)
    }

    @IBAction func DismissView(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Projects", bundle:nil)
        let cont = storyBoard.instantiateViewController(withIdentifier: "HomeNAV")
        self.revealViewController()?.pushFrontViewController(cont, animated: true)
    }
    
    func ReadAllNotification() {
        let AccessToken = AppCommon.sharedInstance.getJSON("Profiledata")["token"].stringValue
        print(AccessToken)
        let params = ["token": AccessToken ,
                      "reading_type" : "all" ,
                      "notification_id" : ""] as [String: Any]
        //AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.ReadNotification, method: .post, parameters: params, tag: 3, header: nil)
    }
    
    func ReadNotification(NotificationID : String){
        let AccessToken = AppCommon.sharedInstance.getJSON("Profiledata")["token"].stringValue
        print(AccessToken)
        let params = ["token": AccessToken ,
                      "reading_type" : "single" ,
                      "notification_id" : NotificationID] as [String: Any]
        //AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.ReadNotification, method: .post, parameters: params, tag: 2, header: nil)
    }
    
    func GetNotifications() {
        let AccessToken = AppCommon.sharedInstance.getJSON("Profiledata")["token"].stringValue
        print(AccessToken)
        let params = ["token": AccessToken ] as [String: Any]
        //AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.GetNotificatios, method: .post, parameters: params, tag: 1, header: nil)
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
                btnBack.target = revealViewController()
                
                btnBack.action = #selector(SWRevealViewController.lefttRevealToggle(_:))
                revealViewController()?.rightViewRevealWidth =  view.frame.width * 0.75
                revealViewController()?.rearViewRevealWidth = view.frame.width * 0.25
                view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
                
            }
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationsTC", for: indexPath) as! NotificationsTC
        cell.lblHeader.text = Notifications[indexPath.row]._msg_header
        cell.lblMessage.text = Notifications[indexPath.row]._msg_body
        cell.lblTime.text = Notifications[indexPath.row]._time
        cell.imgNotification.loadimageUsingUrlString(url: Notifications[indexPath.row]._icon)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        ReadNotification(NotificationID: Notifications[indexPath.row]._id)
        
//        let storyboard = UIStoryboard(name: "ProjectDetails", bundle: nil)
//        let cont = storyboard.instantiateViewController(withIdentifier: "RequestDetailsVC")
//
//        self.present(cont, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }

}
extension NotificationVC : HttpHelperDelegate {
    func receivedResponse(dictResponse: Any, Tag: Int) {
        print(dictResponse)
        AppCommon.sharedInstance.dismissLoader(self.view)
        let json = JSON(dictResponse)
        if Tag == 1 {
            let status =  json["status"]
            let data = json["data"].arrayValue
            let message = json["msg"]
            let UnreadNum = json["unread_num"]
            
            if status.stringValue == "0" {
                
                for json in data{
                    let obj = NotificationModelClass(
                        id: json["id"].stringValue,
                        type: json["type"].stringValue,
                        msg_header: json["msg_header"].stringValue,
                        msg_body: json["msg_body"].stringValue,
                        time: json["time"].stringValue,
                        icon: json["icon"].stringValue,
                        request_id: json["request_id"].stringValue,
                        read_status: json["read_status"].stringValue
                        )
                    Notifications.append(obj)
                }
                if Notifications.count == 0 {
                    imgAlarm.image = UIImage(named: "no-alert")
                }
                lblNotificationNum.text = "لديك \(UnreadNum.stringValue) رساله غير مقروءة"
                tblNotification.reloadData()
            } else if status.stringValue == "500"{
                Loader.showError(message: AppCommon.sharedInstance.localization("Wrong request type"))
            }else if status.stringValue == "1"{
                Loader.showError(message: AppCommon.sharedInstance.localization("some missing data"))
            }else if status.stringValue == "204"{
                Loader.showError(message: AppCommon.sharedInstance.localization("un authorized"))
            }else {
                Loader.showError(message: message.stringValue )
            }
        }else if Tag == 2 {
            let status =  json["status"]
            let message = json["msg"]
            
            if status.stringValue == "0" {
                
                
            }else if status.stringValue == "500"{
                Loader.showError(message: AppCommon.sharedInstance.localization("Wrong request type"))
            }else if status.stringValue == "1"{
                Loader.showError(message: AppCommon.sharedInstance.localization("some missing data"))
            }else if status.stringValue == "204"{
                Loader.showError(message: AppCommon.sharedInstance.localization("un authorized"))
            }else if status.stringValue == "216"{
                Loader.showError(message: AppCommon.sharedInstance.localization("message already read"))
            } else {
                Loader.showError(message: message.stringValue )
            }
            
        }else if Tag == 3 {
            let status =  json["status"]
            let message = json["msg"]
            
            if status.stringValue == "0" {
                
                
            } else if status.stringValue == "500"{
                Loader.showError(message: AppCommon.sharedInstance.localization("Wrong request type"))
            }else if status.stringValue == "1"{
                Loader.showError(message: AppCommon.sharedInstance.localization("some missing data"))
            }else if status.stringValue == "204"{
                Loader.showError(message: AppCommon.sharedInstance.localization("un authorized"))
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

