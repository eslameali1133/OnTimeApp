//
//  Utilities.swift
//  elepur
//
//  Created by Macbook Pro on 10/3/17.
//  Copyright Â© 2017 Snapics. All rights reserved.
//

import Foundation
import UIKit
/**
 Writes the textual representations of the given items into the standard output.
 
 ### Usage Example: ###
 ````
 logar(.error,"index out of range")
 Prints "âŒ index out of range âŒ"
 
 ````
 - Parameters:
 - logarType: debug error or value .
 - message: output message .
 
 */

func getLanguage() -> String {
    return NSLocale.preferredLanguages.first ?? "en"
}

func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        completion()
    }
}

func getTimestamp()->Double{
    
    let timeInterval = NSDate().timeIntervalSince1970
    
    return timeInterval
}

func flag(_ country:String) -> String {
    let base = 127397
    var usv = String.UnicodeScalarView()
    for i in country.utf16 {
        usv.append(UnicodeScalar(base + Int(i))!)
    }
    return String(usv)
}

func getCountryList()->[String]{
    var countries = [String]()
    
     var countryList: [Country] {
        let countries = Countries()
        let countryList = countries.countries
        return countryList
    }
    for country in countryList {
        
        countries.append("\(country.flag ?? "" )-\(country.name ?? "" )")
    }
    
//    for code in NSLocale.isoCountryCodes as [String] {
//        //current = Locale(identifier: "en_US")
//
//
//        let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
//        let name = NSLocale(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
//      //  if code == "US" {
//            countries.append( "\(flag(code))-\(name)" )
//        //}
//    }
    
    return countries
}

func getCountryCode(country:String)->String{
    
    for code in NSLocale.isoCountryCodes as [String] {
        
        let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
        let name = NSLocale(localeIdentifier: "en").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
        if "\(name)" == country {
            return code
        }
    }
    
    
    return ""
}
func isSimulator()->Bool{
    
    return TARGET_OS_SIMULATOR != 0
}

func alert(_ controller:UIViewController,message:String,title:String? = nil){
    // temp value for testing just ....
    let alert = UIAlertController(title: title , message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
        
    }
    alert.addAction(okAction)
    controller.present(alert, animated: true, completion: nil)
    
}

func modelView(controller:UIViewController,storyboardName:String,controllerName:String = "" , object:UIViewController? = nil){
    var  viewController = UIViewController()
    let storyboard = UIStoryboard.init(name: storyboardName, bundle: nil)
    if object == nil {
        viewController = storyboard.instantiateViewController(withIdentifier: controllerName)
    }else{
        viewController = object!
    }
    controller.present(viewController, animated: true, completion: nil)
}

func pushView(controller:UIViewController,storyboardName:String,controllerName:String = "" , object:UIViewController? = nil){
    var  viewController = UIViewController()
    let storyboard = UIStoryboard.init(name: storyboardName, bundle: nil)
    if object == nil {
        viewController = storyboard.instantiateViewController(withIdentifier: controllerName)
    }else{
        viewController = object!
    }
    controller.navigationController?.pushViewController(viewController, animated: true)
}


struct Time {
    
    let start: TimeInterval
    let end: TimeInterval
    let interval: TimeInterval
    
    init(start: TimeInterval, interval: TimeInterval, end: TimeInterval) {
        self.start = start
        self.interval = interval
        self.end = end
    }
    
    init(startHour: TimeInterval, intervalMinutes: TimeInterval, endHour: TimeInterval) {
        self.start = startHour * 60 * 60
        self.end = endHour * 60 * 60
        self.interval = intervalMinutes * 60
    }
    
    var timeRepresentations: [String] {
        let dateComponentFormatter = DateComponentsFormatter()
        dateComponentFormatter.unitsStyle = .positional
        dateComponentFormatter.allowedUnits = [.minute, .hour]
        
        let dateComponent = NSDateComponents()
        return timeIntervals.map { timeInterval in
            dateComponent.second = Int(timeInterval)
            return dateComponentFormatter.string(from: dateComponent as DateComponents)!
        }
    }
    
    var timeIntervals: [TimeInterval]{
        return Array(stride(from: start, to: end, by: interval))
    }
}




