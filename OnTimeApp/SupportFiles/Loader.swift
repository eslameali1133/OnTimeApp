//
//  Loader.swift
//  CarWash
//
//  Created by Mohammad Farhan on 2/6/18.
//  Copyright © 2018 invetechs. All rights reserved.
//

import Foundation
import SVProgressHUD

final class Loader {
    
    static func setup() {
//        SVProgressHUD.setDefaultStyle(.light)
//        SVProgressHUD.setDefaultMaskType(.black)
//        SVProgressHUD.setForegroundColor(UIColor.nocDark)
//        SVProgressHUD.setBackgroundColor(UIColor.lightGray)
//        SVProgressHUD.setMinimumDismissTimeInterval(0.5)
        SVProgressHUD.setMaximumDismissTimeInterval(1.0)
    }
    
    static func show() {
        SVProgressHUD.show()
    }
    
    static func show(message: String) {
        SVProgressHUD.show(withStatus: message)
    }
    
    static func hide() {
        SVProgressHUD.dismiss()
    }
    
    static func showError(message: String) {
        SVProgressHUD.setMaximumDismissTimeInterval(1.0)
        SVProgressHUD.showError(withStatus: message)
    }
    
    static func showSuccess(message: String) {
        SVProgressHUD.showSuccess(withStatus: message)
    }
    
    static func show(success: Bool, error: Error?) {
        guard let error = error else {
            show(success: success)
            return
        }
        showError(message: error.localizedDescription)
    }
    
    static func show(success: Bool) {
        if success {
            showSuccess(message: "Task completed")
        } else {
            showError(message: "Unable to complete task")
        }
    }
}
