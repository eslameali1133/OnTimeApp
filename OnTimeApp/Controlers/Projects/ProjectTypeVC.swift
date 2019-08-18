//
//  ProjectTypeVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 5/28/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit
import SwiftyJSON
class ProjectTypeVC: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource {
    var http = HttpHelper()
    var Departments = [DepartmentModelClass]()
    @IBOutlet weak var collectionImg: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        http.delegate = self
        GetDepartments()
        collectionImg.delegate = self
        collectionImg.dataSource = self
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DINNextLTW23-Regular", size: 20.0)!]
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSideMenue(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Projects", bundle: nil)
        let cont = storyboard.instantiateViewController(withIdentifier: "RightMenuNavigationController")
        cont.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        cont.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        self.present(cont, animated: true, completion: nil)
    }
    @IBAction func btnNextSlide(_ sender: Any) {
    
            if let coll  = collectionImg {
                for cell in coll.visibleCells {
                    let indexPath: IndexPath? = coll.indexPath(for: cell)
                    if ((indexPath?.row)! < Departments.count - 1){
                        let indexPath1: IndexPath?
                        indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)
                        
                        coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                    }
                    else{
                        let indexPath1: IndexPath?
                        indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                        coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                    }
                    
                }
            }
        }
    @IBAction func btnPrevSlide(_ sender: Any) {
        if let coll  = collectionImg {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if ((indexPath?.row)! > 0){
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: (indexPath?.row)! - 1, section: (indexPath?.section)!)
                    
                    coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                }
                else{
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: Departments.count - 1, section: (indexPath?.section)!)
                    coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                }
                
            }
        }
    }
    @IBAction func DismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func GetDepartments(){
        let AccessToken = AppCommon.sharedInstance.getJSON("Profiledata")["token"].stringValue
        print(AccessToken)
        let params = ["token": AccessToken] as [String: Any]
        let headers = [
            "Authorization": AccessToken]
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.GetDepartment, method: .post, parameters: params, tag: 1, header: headers)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Departments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectTypeCVC", for: indexPath) as! ProjectTypeCVC
        cell.lblTitle.text = Departments[indexPath.row]._name
        cell.lblDescreption.text = Departments[indexPath.row]._descr
        print(Departments[indexPath.row]._photo)
        cell.imgType.loadimageUsingUrlString(url:  Departments[indexPath.row]._photo)
//            = UIImage(named: Departments[indexPath.row]._photo)
        cell.ID = Departments[indexPath.row]._id
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }
}
extension ProjectTypeVC : HttpHelperDelegate {
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
                    let obj = DepartmentModelClass(
                        id: json["id"].stringValue,
                        name: json["name"].stringValue,
                        photo: json["img"].stringValue,
                        descr: json["descr"].stringValue
                    )
                    Departments.append(obj)
                }
                collectionImg.reloadData()
                AppCommon.sharedInstance.dismissLoader(self.view)

                
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
