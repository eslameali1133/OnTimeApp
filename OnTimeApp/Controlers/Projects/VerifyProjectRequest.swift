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
    var sum = 0
    
var policiesChecked = false
    var attachment : [UIImage] = []
    var Addons = [AddonsModelClass]()
      var Addonselected = [AddonsModelClass]()
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
    @IBOutlet weak var imgService: customImageView!
    @IBOutlet weak var txtDesc: UITextView!
    @IBOutlet var popupRequest: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        SelectedAddOnes()
print(departmentID + serviceID)
        SetData()
        tblAddones.delegate = self
        tblAddones.dataSource = self
        popupRequest.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(popupRequest)
        popupRequest.isHidden = true
        
        let attributes = [NSAttributedString.Key.font: UIFont(name: "DINNextLTW23-Regular", size: 20)!]
        UINavigationBar.appearance().titleTextAttributes = attributes
        //self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DINNextLTW23-Regular", size: 20.0)!]
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
            imgPolicies.image = UIImage(named: "check (1)")
            policiesChecked = false
        }
    }
    @IBAction func btnVerify(_ sender: Any) {
        if policiesChecked == true{
        AddRequest()
        }else{
            Loader.showError(message: "يجب الموافقة علي الشروط والاحكام الخحاصه ب on time")
        }
    }
    func SelectedAddOnes(){
    
        for i in Addons {
            for j in AddonsR {
                if i._id == j{
                    Addonselected.append(i)
                    sum += Int(i._price)!
                }
            }
            
        }
        let price = Int(RequestServices._price)!
        let tax = (Int(RequestServices._tax_percentage)! * price ) / 100
        print(sum)
        print(tax)
        print(price)
        lblTotalPrice.text = "\(sum + tax + price)"
    }
    func SetData(){
        lblName.text = name
        lblDesc.text = desc
        lblTax.text = RequestServices._tax_percentage
        lblTitle.text = RequestServices._name
        lblServicePrice.text = RequestServices._price
        imgService.loadimageUsingUrlString(url: RequestServices._img)
      
    }
    
    func AddRequest(){
        print(attachment.count)
          AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
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
            print(i)
            count += 1
            
        }
        
        print(params)
        let headers = [
            "Authorization": AccessToken]
        //AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        //http.requestWithBody(url: APIConstants.AddRequest, method: .post, parameters: params, tag: 2, header: headers)
//        Alamofire.upload(
//            multipartFormData: { multipartFormData in
        Alamofire.upload(multipartFormData: { (multipartFormData : MultipartFormData) in
            
            let count = self.attachment.count
            
            for i in 0..<count{
                
                if  let imageData = self.attachment[i].jpegData(compressionQuality: 0.5){
                    multipartFormData.append(imageData, withName: "attachments[\(i)]", fileName: "attachments\(arc4random_uniform(100))"+"-\(i)"+".jpeg", mimeType: "image/jpeg")
                }
            }

                for (key,value) in params {
                if let value = value as? String {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
            }
            print(multipartFormData)
        },
         usingThreshold:UInt64.init(),
          to: "https://appontime.net/mobile/add_request.php" ,
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
                             AppCommon.sharedInstance.dismissLoader(self.view)
                            print(response.debugDescription)
                            AppCommon.sharedInstance.dismissLoader(self.view)
                            // print(response.data!)
                            // print(response.result)
                            let json = JSON(response.data!)
                            print(json)
                            let status =  json["status"]
                            let message = json["msg"]
                            let RequestID = json["id"]
                            if status.stringValue == "0" {
                                

                                if hasContract == true{
                                    let storyBoard : UIStoryboard = UIStoryboard(name: "ProjectDetails", bundle:nil)
                                    let cont = storyBoard.instantiateViewController(withIdentifier: "ProjectMessagesVC")as! ProjectMessagesVC
                                    cont.RequestID = RequestID.stringValue
                                    self.present(cont, animated: true, completion: nil)
                                }
                                else
                                {
                                self.popupRequest.isHidden = false
                                self.popupRequest.backgroundColor = UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.75)
                                }
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
        return Addonselected.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewAddoneTC", for: indexPath) as! ViewAddoneTC
        cell.lblName.text = Addonselected[indexPath.row]._name
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 25
    }
}
