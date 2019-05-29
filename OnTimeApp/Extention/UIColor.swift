//
//  UIColor.swift
//  CarWash
//
//  Created by Mohammad Farhan on 22/12/176/19/17.
//  Copyright © 2017 Mohammad Farhan. All rights reserved.
//

import Foundation
import UIKit


extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}



extension UIColor {
    class func hexColor(string: String) -> UIColor {
        let set = NSCharacterSet.whitespacesAndNewlines
        var colorString = string.trimmingCharacters(in: set).uppercased()
        
        if (colorString.hasPrefix("#")) {
            let index = colorString.index(after: colorString.startIndex)
            colorString = String(colorString[index..<colorString.endIndex])
        }
        
        if (colorString.characters.count != 6) {
            return UIColor.gray
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: colorString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red:   CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue:  CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
        
        
        
    }
    
    class func hexColorWithAlpha(string: String, alpha:CGFloat) -> UIColor {
        let set = NSCharacterSet.whitespacesAndNewlines
        var colorString = string.trimmingCharacters(in: set).uppercased()
        
        if (colorString.hasPrefix("#")) {
            let index = colorString.index(after: colorString.startIndex)
            colorString = String(colorString[index..<colorString.endIndex])
        }
        
        if (colorString.characters.count != 6) {
            return UIColor.gray
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: colorString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red:   CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue:  CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
        
        
        
    }
    
    
}

import UIKit

/// Colors exported automatically by Zeplin.
extension UIColor {
    
    class var nocAzure: UIColor {
        return UIColor(red: 0.0, green: 165.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    }
    
    class var nocDarkLimeGreen: UIColor {
        return UIColor(red: 107.0 / 255.0, green: 219.0 / 255.0, blue: 0.0, alpha: 1.0)
    }
    
    class var nocGreyishBrown: UIColor {
        return UIColor(white: 85.0 / 255.0, alpha: 1.0)
    }
    
    class var nocGunmetal: UIColor {
        return UIColor(red: 84.0 / 255.0, green: 95.0 / 255.0, blue: 102.0 / 255.0, alpha: 1.0)
    }
    
    class var nocBlack: UIColor {
        return UIColor(white: 46.0 / 255.0, alpha: 1.0)
    }
    
    class var nocGrey: UIColor {
        return UIColor(white: 216.0 / 255.0, alpha: 1.0)
    }
    
    class var nocCoolGrey: UIColor {
        return UIColor(red: 152.0 / 255.0, green: 162.0 / 255.0, blue: 168.0 / 255.0, alpha: 1.0)
    }
    
    class var nocDarkLimeGreenTwo: UIColor {
        return UIColor(red: 107.0 / 255.0, green: 212.0 / 255.0, blue: 0.0, alpha: 1.0)
    }
    
    class var nocBrightLightBlue: UIColor {
        return UIColor(red: 47.0 / 255.0, green: 225.0 / 255.0, blue: 245.0 / 255.0, alpha: 1.0)
    }
    
    class var nocVeryLightPink: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 238.0 / 255.0, blue: 238.0 / 255.0, alpha: 1.0)
    }
    
    class var nocCoral: UIColor {
        return UIColor(red: 246.0 / 255.0, green: 84.0 / 255.0, blue: 84.0 / 255.0, alpha: 1.0)
    }
    
    class var nocTomato: UIColor {
        return UIColor(red: 225.0 / 255.0, green: 48.0 / 255.0, blue: 48.0 / 255.0, alpha: 1.0)
    }
    
    class var nocSalmonPink: UIColor {
        return UIColor(red: 254.0 / 255.0, green: 126.0 / 255.0, blue: 128.0 / 255.0, alpha: 1.0)
    }
    
    class var nocPumpkinOrange: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 127.0 / 255.0, blue: 0.0, alpha: 1.0)
    }
    
    class var nocPastelOrange: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 147.0 / 255.0, blue: 92.0 / 255.0, alpha: 1.0)
    }
    
    class var nocPinkishGrey: UIColor {
        return UIColor(white: 195.0 / 255.0, alpha: 1.0)
    }
    
    class var nocWarmGrey: UIColor {
        return UIColor(white: 133.0 / 255.0, alpha: 1.0)
    }
    
    class var nocWarmGreyTwo: UIColor {
        return UIColor(white: 128.0 / 255.0, alpha: 1.0)
    }
    
    class var nocBlueyGrey: UIColor {
        return UIColor(red: 178.0 / 255.0, green: 187.0 / 255.0, blue: 198.0 / 255.0, alpha: 1.0)
    }
    
    class var nocDark: UIColor {
        return UIColor(red: 41.0 / 255.0, green: 52.0 / 255.0, blue: 68.0 / 255.0, alpha: 1.0)
    }
    
    class var nocLightGrey: UIColor {
        return UIColor(white: 242.0 / 255.0, alpha: 1.0)
    }
    
    class var nocWarmGreyThree: UIColor {
        return UIColor(white: 114.0 / 255.0, alpha: 1.0)
    }
    
    class var nocBrownishGrey: UIColor {
        return UIColor(white: 96.0 / 255.0, alpha: 1.0)
    }
    
    class var nocBlackTwo: UIColor {
        return UIColor(white: 55.0 / 255.0, alpha: 1.0)
    }
    
    class var nocBrownishGreyTwo: UIColor {
        return UIColor(white: 106.0 / 255.0, alpha: 1.0)
    }
    
    class var nocGreenishCyan: UIColor {
        return UIColor(red: 54.0 / 255.0, green: 255.0 / 255.0, blue: 182.0 / 255.0, alpha: 1.0)
    }
    
    class var nocYellowTan: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 229.0 / 255.0, blue: 112.0 / 255.0, alpha: 1.0)
    }
    
    class var nocDarkPeach: UIColor {
        return UIColor(red: 226.0 / 255.0, green: 111.0 / 255.0, blue: 111.0 / 255.0, alpha: 1.0)
    }
    
    class var nocLightAquamarine: UIColor {
        return UIColor(red: 96.0 / 255.0, green: 255.0 / 255.0, blue: 213.0 / 255.0, alpha: 1.0)
    }
    
    class var nocDarkLimeGreenThree: UIColor {
        return UIColor(red: 113.0 / 255.0, green: 222.0 / 255.0, blue: 0.0, alpha: 1.0)
    }
    
    class var nocWarmGreyFour: UIColor {
        return UIColor(white: 112.0 / 255.0, alpha: 1.0)
    }
    
    class var nocDodgerBlue: UIColor {
        return UIColor(red: 61.0 / 255.0, green: 172.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    }
    
    class var nocGreyishBrownTwo: UIColor {
        return UIColor(white: 86.0 / 255.0, alpha: 1.0)
    }
    
    class var nocWarmGreyFive: UIColor {
        return UIColor(red: 127.0 / 255.0, green: 119.0 / 255.0, blue: 119.0 / 255.0, alpha: 1.0)
    }
    
    class var nocMediumGrey: UIColor {
        return UIColor(red: 131.0 / 255.0, green: 131.0 / 255.0, blue: 122.0 / 255.0, alpha: 1.0)
    }
    
    class var nocWhite: UIColor {
        return UIColor(white: 240.0 / 255.0, alpha: 1.0)
    }
    
    class var nocPinkishGreyTwo: UIColor {
        return UIColor(white: 204.0 / 255.0, alpha: 1.0)
    }
    
    class var nocOffWhite: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0)
    }
    
    class var nocWheat: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 204.0 / 255.0, blue: 136.0 / 255.0, alpha: 1.0)
    }
    
    class var nocFiltersButtonsGray: UIColor {
        return UIColor(red: 204.0 / 255.0, green: 204.0 / 255.0, blue: 204.0 / 255.0, alpha: 1.0)
    }
    
    class var nocWhiteTwo: UIColor {
        return UIColor(white: 244.0 / 255.0, alpha: 1.0)
    }
    
    class var nocWhiteThree: UIColor {
        return UIColor(white: 233.0 / 255.0, alpha: 1.0)
    }
    
    class var nocBattleshipGrey: UIColor {
        return UIColor(red: 103.0 / 255.0, green: 110.0 / 255.0, blue: 134.0 / 255.0, alpha: 1.0)
    }
    
    class var nocBlackThree: UIColor {
        return UIColor(white: 54.0 / 255.0, alpha: 1.0)
    }
    
    class var nocBlushPink: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 100.0 / 255.0, blue: 102.0 / 255.0, alpha: 1.0)
    }
    
    class var nocOrangeish: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 152.0 / 255.0, blue: 65.0 / 255.0, alpha: 1.0)
    }
    
    class var nocGreyishBlue46: UIColor {
        return UIColor(red: 93.0 / 255.0, green: 126.0 / 255.0, blue: 165.0 / 255.0, alpha: 0.46)
    }
    
    class var nocAquaMarine: UIColor {
        return UIColor(red: 50.0 / 255.0, green: 217.0 / 255.0, blue: 236.0 / 255.0, alpha: 1.0)
    }
    
    class var nocTealish: UIColor {
        return UIColor(red: 50.0 / 255.0, green: 194.0 / 255.0, blue: 210.0 / 255.0, alpha: 1.0)
    }
    
    class var nocSandstone: UIColor {
        return UIColor(red: 197.0 / 255.0, green: 159.0 / 255.0, blue: 112.0 / 255.0, alpha: 1.0)
    }
    
    class var nocPeach: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 199.0 / 255.0, blue: 130.0 / 255.0, alpha: 1.0)
    }
    
    class var nocWhite50: UIColor {
        return UIColor(white: 217.0 / 255.0, alpha: 0.5)
    }
    
    class var nocPaleGrey: UIColor {
        return UIColor(red: 239.0 / 255.0, green: 240.0 / 255.0, blue: 244.0 / 255.0, alpha: 1.0)
    }
    
    class var nocAlertRed: UIColor {
        return UIColor(red: 1, green: 100.0 / 255.0, blue: 102.0 / 255.0, alpha: 1.0)
    }
    
    class var nocBrownishGreyThree: UIColor {
        return UIColor(white: 105.0 / 255.0, alpha: 1.0)
    }
    
    class var nocWaterBlue: UIColor {
        return UIColor(red: 15.0 / 255.0, green: 145.0 / 255.0, blue: 217.0 / 255.0, alpha: 1.0)
    }
    
    class var nocGray: UIColor {
        return UIColor(red: 101.0 / 255.0, green: 101.0 / 255.0, blue: 101.0 / 255.0, alpha: 1.0)
    }
    
    class var nocLightGrayGray: UIColor {
        return UIColor(red: 230.0 / 255.0, green: 230.0 / 255.0, blue: 230.0 / 255.0, alpha: 1.0)
    }
    
    class var nocDarkerGrey: UIColor {
        return UIColor(white: 77.0 / 255.0, alpha: 1.0)
    }
    
    class var nocDarkGrey: UIColor {
        return UIColor(white: 105.0 / 255.0, alpha: 1.0)
    }
    
    class var nocBlueWithAHintOfPurple: UIColor {
        return UIColor(red: 83.0 / 255.0, green: 63.0 / 255.0, blue: 180.0 / 255.0, alpha: 1.0)
    }
    
    class var nocLightNavy: UIColor {
        return UIColor(red: 27.0 / 255.0, green: 100.0 / 255.0, blue: 133.0 / 255.0, alpha: 1.0)
    }
    
    class var nocBackgroundGray: UIColor {
        return UIColor(white: 0.956, alpha: 1.0)
    }
    
    class var nocDarkBackgroundGray: UIColor {
        return UIColor(white: 0.937, alpha: 1.0)
    }
    
    class var nocBackgroundExtraLight: UIColor {
        return UIColor(red: 243.0/255.0, green: 244.0 / 255.0, blue: 245.0 / 255.0, alpha: 1.0)
    }
    
    class var nocDarkPurple: UIColor {
        return UIColor(red: 71.0 / 255.0, green: 50.0 / 255.0, blue: 98.0 / 255.0, alpha: 1.0)
    }
    
    class var nocLime: UIColor {
        return UIColor(red: 154.0 / 255.0, green: 255.0 / 255.0, blue: 51.0 / 255.0, alpha: 1.0)
    }
    
    class var nocProgressBlue: UIColor {
        return UIColor(red: 147 / 255.0, green: 219 / 255.0, blue: 255 / 255.0, alpha: 1.0)
    }
    
    class var nocProgressGreen: UIColor {
        return UIColor(red: 176 / 255.0, green: 248 / 255.0, blue: 187 / 255.0, alpha: 1.0)
    }
    
    class var nocProgressRed: UIColor {
        return UIColor(red: 255 / 255.0, green: 171 / 255.0, blue: 171 / 255.0, alpha: 1.0)
    }
}
