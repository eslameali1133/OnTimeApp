//
//  ProjectTypeCVC.swift
//  OnTimeApp
//
//  Created by Husseinomda16 on 6/10/19.
//  Copyright © 2019 Ontime24. All rights reserved.
//

import UIKit

class ProjectTypeCVC: UICollectionViewCell {
    var ID = ""
    @IBOutlet weak var lblDescreption: UITextView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgType: customImageView!
    
    @IBAction func btnAdd(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Projects", bundle:nil)
        let cont = storyBoard.instantiateViewController(withIdentifier: "NewProjectRequest")as! NewProjectRequest
        cont.department_id = ID
    let currentController = self.getCurrentViewController()
    currentController?.present(cont, animated: true, completion: nil)
    }
func getCurrentViewController() -> UIViewController? {
    
    if let rootController = UIApplication.shared.keyWindow?.rootViewController {
        var currentController: UIViewController! = rootController
        while( currentController.presentedViewController != nil ) {
            currentController = currentController.presentedViewController
        }
        return currentController
    }
    return nil
    
}
}
