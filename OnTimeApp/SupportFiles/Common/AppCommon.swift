//
//  AppCommon.swift
//  AshakAlena
//
//  Created by Mohammad Farhan on 22/12/176/8/17.
//  Copyright © 2017 Mohammad Farhan. All rights reserved.
//

import Foundation
import UIKit
import  SwiftyJSON
//import JBWebViewController
//import SwiftyJSON


class AppCommon: UIViewController {
    
    static let sharedInstance = AppCommon()

    func dismissLoader(_ view:UIView){
        view.viewWithTag(1000)?.removeFromSuperview()
    }
    
    
    func roundingUIView( _ aView: UIView!,  cornerRadiusParam: CGFloat!) {
        aView.layer.cornerRadius = cornerRadiusParam
        aView.clipsToBounds = true
    }

    
    func saveJSON(json: JSON, key:String){
        let jsonString = json.rawString()!
        UserDefaults.standard.setValue(jsonString, forKey: key)
        //            UserDefaults.synchronize()
    }
    
    func getJSON(_ key: String)->JSON {
        var p = ""
        if let buildNumber = UserDefaults.standard.value(forKey: key) as? String {
            p = buildNumber
        }else {
            p = ""
        }
        if  p != "" {
            if let json = p.data(using: String.Encoding.utf8, allowLossyConversion: false) {
                return try! JSON(data: json)
            } else {
                return JSON("nil")
            }
        } else {
            return JSON("nil")
        }
    }
    
    func GotoVerificationcode(vc: UIViewController,UserID: String,userType:Bool,Mobile:String) {
//        let sb = UIStoryboard(name: "Authstory", bundle: nil)
////        let controller = sb.instantiateViewController(withIdentifier: "VerifyCodeVC") as! VerifyCodeVC
//
//        controller.UserID = UserID
//        controller.UserType = userType
//        controller.mobile = Mobile
//        controller.FalgComeFromRegister = true
//        vc.navigationController?.pushViewController(controller, animated: true)
    }
    func ShowHome() {
        let sb = UIStoryboard(name: "HomeVender", bundle: nil)
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.rootViewController = sb.instantiateInitialViewController()
    }
    
    func showlogin(vc: UIViewController) {
        let sb = UIStoryboard(name: "Profile", bundle: nil)
        let controller = sb.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
    vc.show(controller, sender: true)
//        vc.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    
    
//
//    func showLogin(vc: UIViewController) {
//        let sb = UIStoryboard(name: "Login", bundle: nil)
//        let controller = sb.instantiateViewController(withIdentifier: "Login")
//        vc.revealViewController().setFront(controller, animated: true)
//    }

    
//    func OpenUrl(_ URL:String){
//        let controller = JBWebViewController(url: Foundation.URL(string: URL))
//        if let topController = UIApplication.topViewController() {
//            controller?.show(from: topController)
//        }
//    }
    
    
    func alert(title: String, message: String, controller: UIViewController, actionTitle: String, actionStyle: UIAlertAction.Style) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: actionStyle, handler: nil))
        alert.view.tintColor = UIColor.hexColor(string: "023f82")

        controller.present(alert, animated: true, completion: nil)

    }
    
    
    func alertWith(title: String, message: String, controller: UIViewController, actionTitle: String, actionStyle: UIAlertAction.Style, withCancelAction: Bool, completion: @escaping () -> Void) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: actionStyle, handler: { (action) in
            completion()
        }))
        alert.view.tintColor = UIColor.hexColor(string: "023f82")
        if withCancelAction {
        alert.addAction(UIAlertAction(title: AppCommon.sharedInstance.localization("cancel"), style: .cancel, handler: nil))
        }
        
        controller.present(alert, animated: true, completion: nil)
    }

//    func alertWithLogin(vc: UIViewController, isFromSideMenu: Bool) {
//        let alert = UIAlertController.init(title: "", message: AppCommon.sharedInstance.localization("loginToContinue"), preferredStyle: .alert)
//        alert.view.tintColor = UIColor.hexColor(string: "023f82")
//
//        alert.addAction(UIAlertAction(title: AppCommon.sharedInstance.localization("login"), style: .default, handler: { (action) in
//            let sb = UIStoryboard(name: "Login", bundle: nil)
//            let controller = sb.instantiateViewController(withIdentifier: "Login")
//            vc.revealViewController().setFront(controller, animated: true)
//            if isFromSideMenu {
//                if SharedData.SharedInstans.getLanguage() == "ar" && L102Language.currentAppleLanguage() == "ar" {
//                    vc.revealViewController().rightRevealToggle(animated: true)
//                } else {
//                    vc.presentViewController(<#UIViewController#>).revealToggle(animated: true)
//                }
//            }
//        }))
//
//        alert.addAction(UIAlertAction(title: AppCommon.sharedInstance.localization("cancel"), style: .cancel, handler: nil))
//        vc.present(alert, animated: true, completion: nil)
//    }

    
    func NotFound(_ view:UITableView! , Msg:String? , Count:Int){
        if(Count <= 0){
            let  notFound: UILabel = UILabel()
            notFound.text = Msg
            notFound.font = UIFont(name: "HacenTunisiaBd", size: 12)
            notFound.numberOfLines = 2
            notFound.textAlignment = NSTextAlignment.center
            view.backgroundView = notFound
            view.separatorStyle=UITableViewCell.SeparatorStyle.none
            
        }else{
            let  notFound: UILabel = UILabel()
            notFound.text = ""
            notFound.textAlignment = NSTextAlignment.center
            view.backgroundView = notFound
            view.separatorStyle=UITableViewCell.SeparatorStyle.none
        }
        
    }
    
    func textInView(_ view:UIView! , Msg:String?,size: CGFloat,txtColor: UIColor){
        let  notFound: UILabel = UILabel()
        notFound.text = Msg
        notFound.font = UIFont(name: "HacenTunisiaBd", size: size)
        notFound.textColor = txtColor
        notFound.textAlignment = NSTextAlignment.center
        notFound.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        view.addSubview(notFound)
    }
    
    
    func Alert(_ Message:String?,Title:String?,BtnOk:String?,Context:AnyObject ,Actions:@escaping ()->Void?){
        let WrongAlert=UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
        WrongAlert.addAction(UIAlertAction(title: BtnOk, style: UIAlertAction.Style.default, handler: { Action in
            Actions()
        }))
        Context.present(WrongAlert, animated: true, completion: nil)
    }
    
    func ShowLoader(_ view:UIView,color:UIColor){
        let Loader  = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        Loader.backgroundColor = color
        Loader.tag = 1000
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        loadingIndicator.center = Loader.center
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        loadingIndicator.color = UIColor.black
        loadingIndicator.startAnimating();
        Loader.addSubview(loadingIndicator)
        view.addSubview(Loader)
    }
    
    
    
    
    func localization(_ key:String)->String {
        let lang = SharedData.SharedInstans.getLanguage()
        
        if let path = Bundle.main.path(forResource: "lang-\(lang)", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                //                let jsonObj = JSON(data: data)
                let jsonDic = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                //                print(jsonDic!["couponNumber"]!)
                //                print("jsonData:\(jsonDic!)")
                if jsonDic![key] != nil {
                    return jsonDic![key] as! String
                }
                if !(jsonDic?.isEmpty)! {
                    //                    print("jsonData:\(jsonObj)")
                    return "_"+key
                } else {
                    print("Could not get json from file, make sure that file contains valid json.")
                    return "_"+key
                    
                }
            } catch let error {
                print(error.localizedDescription)
                return "_"+key
                
            }
        } else {
            print("Invalid filename/path.")
            return "_"+key
            
        }
        
    }
    
}

