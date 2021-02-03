//
//  Inicio.swift
//  BMI-Calorie-Calculator
//
//  Created by Lucas Berger on 26/1/21.
//

import UIKit

class Inicio: UIViewController {
    @IBOutlet weak var bmiButton: UIButton!
    @IBOutlet weak var caloriesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1770251393, green: 0.2089989185, blue: 0.2513588071, alpha: 1)
        navigationItem.title = "Fitness Calculator"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DINAlternate-Bold", size: 23.0)!, .foregroundColor: UIColorFromRGB(rgbValue: 0x00adb5)]
    }
    
    /*
     Function to set navigationBar title color as RGB.
     Reason of creation: cannot put 'ColorLiteral'.
     */
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "BmiToCalculator") {
            let backItem = UIBarButtonItem()
            backItem.title = "Something Else"
            navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
        }
    } */
    
}
