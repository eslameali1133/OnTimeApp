//
//  doneProjectVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 6/17/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit
import SwiftyJSON
var Gdonecount = "0"
    class doneProjectVC: UIViewController , UITableViewDataSource , UITableViewDelegate {
        var http = HttpHelper()
        var HomeRequests = [HomeRequestModelClass]()
        @IBOutlet weak var tblProjects: UITableView!
        override func viewDidLoad() {
           
            super.viewDidLoad()
            http.delegate = self
            GetHomeRequests()
            tblProjects.delegate = self
            tblProjects.dataSource = self
            // Do any additional setup after loading the view.
        }
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return HomeRequests.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectTC", for: indexPath) as! ProjectTC
            let width = (100 * Int(cell.viewMain.frame.width) ) / 100
            cell.viewStatus.frame.size.width = CGFloat(width)
            cell.id = HomeRequests[indexPath.row]._id
            cell.percentage = HomeRequests[indexPath.row]._percentage
            cell.icon.loadimageUsingUrlString(url: HomeRequests[indexPath.row]._icon)
            cell.statusdescr.text = HomeRequests[indexPath.row]._status_descr
            cell.status.text = HomeRequests[indexPath.row]._status
            cell.img.loadimageUsingUrlString(url: HomeRequests[indexPath.row]._img)
            cell.desce.text = HomeRequests[indexPath.row]._request_descr
            cell.name.text = HomeRequests[indexPath.row]._request_name
            return cell
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let storyBoard : UIStoryboard = UIStoryboard(name: "ProjectDetails", bundle:nil)
            let cont = storyBoard.instantiateViewController(withIdentifier: "ProjectMessagesVC")as! ProjectMessagesVC
            cont.RequestID = HomeRequests[indexPath.row]._id
            self.present(cont, animated: true, completion: nil)
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 75
        }
        // all - under_preview - in_progress - finished
        func GetHomeRequests(){
            let AccessToken = AppCommon.sharedInstance.getJSON("Profiledata")["token"].stringValue
            print(AccessToken)
            let params = ["token": AccessToken,
                          "type" : "finished" ] as [String: Any]
            AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
            http.requestWithBody(url: APIConstants.GetUserRequests, method: .post, parameters: params, tag: 1, header: nil)
        }
}
extension doneProjectVC : HttpHelperDelegate {
    func receivedResponse(dictResponse: Any, Tag: Int) {
        print(dictResponse)
        AppCommon.sharedInstance.dismissLoader(self.view)
        let json = JSON(dictResponse)
        if Tag == 1 {
            let status =  json["status"]
            let data = json["data"].arrayValue
            let message = json["msg"]
            
            if status.stringValue == "0" {
                
                for json in data{
                    let obj = HomeRequestModelClass(
                        id: json["id"].stringValue,
                        request_name: json["request_name"].stringValue,
                        request_descr: json["request_descr"].stringValue,
                        img: json["img"].stringValue,
                        status: json["status"].stringValue,
                        status_descr: json["status_descr"].stringValue,
                        icon: json["icon"].stringValue,
                        percentage: json["percentage"].stringValue,
                        componants_ready: json["componants_ready"].stringValue,
                        create_time: json["create_time"].stringValue,
                        end_time: json["end_time"].stringValue,
                        has_contract: json["has_contract"].stringValue,
                        has_price: json["has_price"].stringValue,
                        new_message: json["new_message"].stringValue,
                        start_time: json["start_time"].stringValue,
                        stop_time: json["stop_time"].stringValue
                    )
                    HomeRequests.append(obj)
                }
                HomeRequests.reverse()
                tblProjects.reloadData()
                Gdonecount = "\(HomeRequests.count)"; AppCommon.sharedInstance.dismissLoader(self.view);
                
                
            } else {
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
