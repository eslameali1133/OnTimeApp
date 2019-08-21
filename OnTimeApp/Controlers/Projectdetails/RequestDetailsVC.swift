//
//  RequestDetailsVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/28/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit
import SwiftyJSON
class RequestDetailsVC: UIViewController , UITableViewDelegate , UITableViewDataSource {

    var ComponentsArray = [ComponentModelClass]()
    var RequestID = ""
    var http = HttpHelper()
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblTax: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblComponent: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgRequest: UIImageView!
    @IBOutlet weak var tblComponents: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DINNextLTW23-Regular", size: 20.0)!]
        tblComponents.dataSource = self
        tblComponents.delegate = self
        http.delegate = self
        GetCompnents()
        // Do any additional setup after loading the view.
    }
    
   
    @IBAction func btnAccept(_ sender: Any) {
        AcceptOrRefuse(decision: "accepted")
    }
    
    @IBAction func btnReject(_ sender: Any) {
        AcceptOrRefuse(decision: "refused")
       // self.dismiss(animated: true, completion: nil)
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
    func AcceptOrRefuse (decision : String){
        print(RequestID)
        let AccessToken = AppCommon.sharedInstance.getJSON("Profiledata")["token"].stringValue
        print(AccessToken)
        let params = ["token": AccessToken,
                      "request_id" : RequestID ,
                      "decision" : decision ] as [String: Any]
        let headers = [
            "Authorization": AccessToken]
        //AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.AcceptOrRefuseComponent, method: .post, parameters: params, tag: 2, header: headers)
    }
    
    func GetCompnents(){
        print(RequestID)
        let AccessToken = AppCommon.sharedInstance.getJSON("Profiledata")["token"].stringValue
        print(AccessToken)
        let params = ["token": AccessToken,
                      "request_id" : RequestID ] as [String: Any]
        let headers = [
            "Authorization": AccessToken]
        //AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.GetRequestComponent, method: .post, parameters: params, tag: 1, header: headers)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ComponentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComponentsTC", for: indexPath) as! ComponentsTC
        cell.lbName.text = ComponentsArray[indexPath.row]._component_name
        cell.lblPrice.text = ComponentsArray[indexPath.row]._price
        cell.duration = ComponentsArray[indexPath.row]._duration
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
extension RequestDetailsVC : HttpHelperDelegate {
    func receivedResponse(dictResponse: Any, Tag: Int) {
        print(dictResponse)
        AppCommon.sharedInstance.dismissLoader(self.view)
        let json = JSON(dictResponse)
        if Tag == 1 {
           
            let status =  json["status"]
            let data = json["data"].arrayValue
            let message = json["msg"]
            let total = json["total"]
            let tax = json["tax"]
            if status.stringValue == "0" {
                
                for json in data{
                    let obj = ComponentModelClass(
                        component_name: json["component_name"].stringValue,
                        price: json["price"].stringValue,
                        duration: json["duration"].stringValue
                        
                    )
                    //print(obj)
                    ComponentsArray.append(obj)
                    
                }
                lblTax.text = tax.stringValue
                lblTotal.text = total.stringValue
                tblComponents.reloadData()
                
            } else {
                Loader.showError(message: message.stringValue )
            }
        }else if Tag == 2 {
            
            let status =  json["status"]
            let message = json["msg"]
            
            if status.stringValue == "0" {
                
                
                
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
