//
//  SharedData.swift
//  CarWash
//
//  Created by Mohammad Farhan on 22/12/1710/11/17.
//  Copyright © 2017 CarWash. All rights reserved.
//

import Foundation

class SharedData{
    
    static let SharedInstans = SharedData()
    let defaults = UserDefaults.standard

    let IsLogin = "IsLogin"
     let IsActive = "IsActive"
    let Language = "Language"

    func SetIsLogin(_ isLogin:Bool){
        defaults.set(isLogin, forKey: IsLogin)
    }
    
    func GetIsLogin()->Bool{
        if (UserDefaults.standard.object(forKey: IsLogin) != nil) {
            return defaults.bool(forKey: IsLogin)
        }else{
            return false
        }
    }
    
    func SetIsActive(_ isActive:Bool){
        defaults.set(isActive, forKey: IsActive)
    }
    
    func GetIsActive()->Bool{
        if (UserDefaults.standard.object(forKey: IsActive) != nil) {
            return defaults.bool(forKey: IsActive)
        }else{
            return false
        }
    }
    
    func setLanguage(_ language:String){
        defaults.set(language, forKey: Language)
    }
    
    func getLanguage()->String{
        if (UserDefaults.standard.object(forKey: Language) != nil) {
            return defaults.string(forKey: Language)!
        }else{
            return "en"
        }
    }


    
}
