//
//  PublicFunctions.swift
//  BMI-Calorie-Calculator
//
//  Created by Lucas Berger on 5/2/21.
//

import UIKit

class PublicFunctions {
    
    /*
     Function to set navigationBar title color as RGB.
     Reason of creation: cannot put 'ColorLiteral'.
     */
    static func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
