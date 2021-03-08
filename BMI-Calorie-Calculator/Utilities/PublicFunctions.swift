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
    
    static func showAlert(in viewController: UIViewController) {
        // create the alert
        let alert = UIAlertController(title: "Not Valid Inputs", message: "Please check if your inputs were written correctly.", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func convertFeetToMeters(feet: Double, inches: Double) -> Double {
        var heightCm = (Double(Int(feet)) * 0.3048) + (inches * 0.0254)
        heightCm = Double(round(1000*heightCm)/1000)
        
        return heightCm
    }
    
    static func convertLbToKg(weight: Double) -> Double {
        var weightKg = weight * 0.45359237
        weightKg = Double(round(10*weightKg)/10)
        
        return weightKg
    }
}
