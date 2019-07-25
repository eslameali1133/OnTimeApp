//
//  VerifyProjectRequest.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/28/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
class VerifyProjectRequest: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    
var policiesChecked = false
    var attachment = [UIDocument]()
    var Addons = [AddonsModelClass]()
    var RequestServices : RequestNServicesModelClass!
    var tit = ""
    var name = ""
    var desc = ""
    var departmentID = ""
    var serviceID = ""
    @IBOutlet weak var imgPolicies: UIImageView!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblTax: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var tblAddones: UITableView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblServicePrice: UILabel!
    @IBOutlet weak var imgService: UIImageView!
    @IBOutlet weak var txtDesc: UITextView!
    @IBOutlet var popupRequest: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
print(departmentID + serviceID)
        SetData()
        tblAddones.delegate = self
        tblAddones.dataSource = self
        popupRequest.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(popupRequest)
        popupRequest.isHidden = true
        
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

    @IBAction func btnPoliciess(_ sender: Any) {
        if policiesChecked == false {
            imgPolicies.image = UIImage(named: "check")
            policiesChecked = true
        }else{
            imgPolicies.image = UIImage(named: "check")
            policiesChecked = false
        }
    }
    @IBAction func btnVerify(_ sender: Any) {
        AddRequest()
    }
    func SetData(){
        lblName.text = name
        lblDesc.text = desc
        lblTax.text = RequestServices._tax_percentage
        lblTotalPrice.text = ""
        lblTitle.text = RequestServices._name
        lblServicePrice.text = RequestServices._price
        imgService.image = UIImage(named: RequestServices._img)
        
    }
    
    func AddRequest(){
        let AccessToken = AppCommon.sharedInstance.getJSON("Profiledata")["token"].stringValue
        print(AccessToken)
        var params = ["token": AccessToken ,
                      "department_id":departmentID ,
                      "service_id":serviceID ,
                      "name" : lblName.text!,
                      "descr" : lblDesc.text!,
                      "attachments" : attachment
            ] as [String: Any]
        
        var count = 1
        for  i in AddonsR
        {
            params["addons[\(count)]"] = i
            count += 1
            
        }
        
        print(params)
        let headers = [
            "Authorization": AccessToken]
        //AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        //http.requestWithBody(url: APIConstants.AddRequest, method: .post, parameters: params, tag: 2, header: headers)
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                for (key,value) in params {
                    if let value = value as? String {
                        multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    }
                }
                
                //if let data = self.imgPID.image!.jpegData(compressionQuality: 0.5){
                //    multipartFormData.append(data, withName: "photo", fileName: "photo\(arc4random_uniform(100))"+".jpeg", mimeType: "jpeg")
                
                //}
                
        },
            usingThreshold:UInt64.init(),
            to: "https://appontime.net/mobile/add_request.php",
            method: .post, headers: headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (progress) in
                        print(progress)
                    })
                    upload.responseJSON { response in
                        // If the request to get activities is succesfull, store them
                        if response.result.isSuccess{
                            print(response.debugDescription)
                            AppCommon.sharedInstance.dismissLoader(self.view)
                            // print(response.data!)
                            // print(response.result)
                            let json = JSON(response.data)
                            print(json)
                            let status =  json["status"]
                            let message = json["msg"]
                            let RequestID = json["id"]
                            if status.stringValue == "0" {
                                
//                                Loader.showSuccess(message: AppCommon.sharedInstance.localization("The contract was successfully signed"))
//
//                                let sb = UIStoryboard(name: "ProjectDetails", bundle: nil)
//                                let controller = sb.instantiateViewController(withIdentifier: "AaqdVerificationCode") as! AaqdVerificationCode
//                                self.show(controller, sender: true)
                                if hasContract == true{
                                    let storyBoard : UIStoryboard = UIStoryboard(name: "ProjectDetails", bundle:nil)
                                    let cont = storyBoard.instantiateViewController(withIdentifier: "ProjectMessagesVC")as! ProjectMessagesVC
                                    cont.RequestID = RequestID.stringValue
                                    self.present(cont, animated: true, completion: nil)
                                }
                                self.popupRequest.isHidden = false
                                self.popupRequest.backgroundColor = UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.75)
                                
                            }else{
                                Loader.showError(message: message.stringValue)
                            }
                            
                        } else {
                            let errorMessage = "ERROR MESSAGE: "
                            if let data = response.data {
                                // Print message
                                print(errorMessage)
                                AppCommon.sharedInstance.dismissLoader(self.view)
                                
                                
                                
                            }
                            print(errorMessage) //Contains General error message or specific.
                            print(response.debugDescription)
                            AppCommon.sharedInstance.dismissLoader(self.view)
                        }
                        
                        
                    }
                case .failure(let encodingError):
                    print("FALLE ------------")
                    print(encodingError)
                    AppCommon.sharedInstance.dismissLoader(self.view)
                }
        }
        )
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Addons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewAddoneTC", for: indexPath) as! ViewAddoneTC
        cell.lblName.text = Addons[indexPath.row]._name
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 25
    }
}
