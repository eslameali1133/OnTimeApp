//
//  Enum.swift
//  CarWash
//
//  Created by Mohammad Farhan on 22/12/1710/11/17.
//  Copyright © 2017 CarWash. All rights reserved.
//

import Foundation

enum ScreenNameEnum:String {
    
//    case home = "Home"
    case profile = "Profile"
    case myCar = "MyCar"
    case carWash = "CarWash"
    case engineOilChange = "EngineOilChange"
    case history = "History"
    case aboutUs = "About"
    case login = "Login"
    case signup = "Signup"
    case language = "Language"
    case header = "header"

    
    static func mapServiceTapped(screenNameEnum: ScreenNameEnum) -> Int {
        var index: Int!
        
        switch screenNameEnum {
        case ScreenNameEnum.myCar:
            index = 0
        case ScreenNameEnum.carWash:
            index = 2
        case ScreenNameEnum.engineOilChange:
            index = 1
        default: break
        }
        
        return index

    }
    
    
    static func mapSideMenu(screenNameEnum: ScreenNameEnum) -> Int {
        
        var index: Int!
        
        switch screenNameEnum {
        case ScreenNameEnum.header:
            index = 0
//        case ScreenNameEnum.home:
//            index = 1
        case ScreenNameEnum.profile:
            index = 1
        case ScreenNameEnum.myCar:
            index = 2
        case ScreenNameEnum.carWash:
            index = 3
        case ScreenNameEnum.engineOilChange:
            index = 4
        case ScreenNameEnum.history:
            index = 5
        case ScreenNameEnum.aboutUs:
            index = 7
        case ScreenNameEnum.language:
            index = 6
        case ScreenNameEnum.login:
            index = 8

        default: break
        }
        
        return index
        
    }
    
    
    
    static func mapScreenName(index: Int) -> String {
        
        var screenName: String!
        
        switch index {
        
        case 0:
            screenName = ScreenNameEnum.header.rawValue
//        case 1:
//            screenName = ScreenNameEnum.home.rawValue
        case 1 :
            screenName = ScreenNameEnum.profile.rawValue
        case 2 :
            screenName = ScreenNameEnum.myCar.rawValue
        case 3 :
            screenName = ScreenNameEnum.carWash.rawValue
        case 4 :
            screenName = ScreenNameEnum.engineOilChange.rawValue
        case 5 :
            screenName = ScreenNameEnum.history.rawValue
        case 7 :
            screenName = ScreenNameEnum.aboutUs.rawValue
        case 8 :
            screenName = ScreenNameEnum.login.rawValue
            
        default: break
            
        }
        
        return screenName
        
    }
    
    
    
}

//enum StoryboardName:String {
//    case Landing = "Landing"
//    case SignIn = "SignIn"
//    case SignUp = "SignUp"
//    case VerifyMobile = "VerifyMobile"
//    case PassengerPickup = "PassengerPickup"
//    case Profile = "Profile"
//    case ForgetPassword = "ForgetPassword"
//    case VehicalType = "VehicalType"
//    case Tutorial = "Tutorial"
//    case SideMenu = "SideMenu"
//    case DriverPickup = "DriverPickup"
//    case About = "About"
//    case Setting = "Setting"
//    case Terms = "Terms"
//
//
//}



//enum HTTPMethod: String {
//    case options = "OPTIONS"
//    case get     = "GET"
//    case head    = "HEAD"
//    case post    = "POST"
//    case put     = "PUT"
//    case patch   = "PATCH"
//    case delete  = "DELETE"
//    case trace   = "TRACE"
//    case connect = "CONNECT"
//}

enum statusCode {
    
    static let NOT_FOUND = 404
    static let OK = 200
    static let BAD_GATEWAY = 502
    static let SERVICE_UNAVAILABLE = 503
    static let NO_CONTENT = 204
    static let ACCEPTED = 0
    static let CREATED = 0
    
    
}


