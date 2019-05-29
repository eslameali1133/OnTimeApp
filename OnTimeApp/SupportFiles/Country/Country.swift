//
//  Country.swift
//  CarWash
//
//  Created by Mohammad Farhan on 22/12/1710/30/17.
//  Copyright © 2017 CarWash. All rights reserved.
//


import UIKit

public class Country: NSObject {
    
    public var countryCode: String
    public var phoneExtension: String
    
    public var name: String? {
        let current = Locale(identifier: "en_US")
        return current.localizedString(forRegionCode: countryCode) ?? nil
    }
    
    public var flag: String? {
        return flag(country: countryCode)
    }
    
    init(countryCode: String, phoneExtension: String) {
        self.countryCode = countryCode
        self.phoneExtension = phoneExtension
    }
    
    private func flag(country:String) -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in country.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
}

