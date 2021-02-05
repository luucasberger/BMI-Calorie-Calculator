//
//  BMICalculator.swift
//  BMI-Calorie-Calculator
//
//  Created by Lucas Berger on 29/1/21.
//

import UIKit

class BMICalculator: UIViewController {
    @IBOutlet var resultBMI: UILabel!
    @IBOutlet var imperialUnitButton: UIButton!
    @IBOutlet var metricUnitButton: UIButton!
    var imperialButtonIsWhite = false
    var metricButtonIsWhite = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "BMI Calculator"
        
//        orangeColor = PublicFunctions.UIColorFromRGB(rgbValue: 0xff971d)
//        whiteColor = PublicFunctions.UIColorFromRGB(rgbValue: 0xffffff)
    }
    @IBAction func metricUnitPressed(_ sender: UIButton, forEvent event: UIEvent) {
        if (metricButtonIsWhite) {
            metricUnitButton.backgroundColor = PublicFunctions.UIColorFromRGB(rgbValue: 0xff971d)
            metricUnitButton.titleLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            imperialUnitButton.backgroundColor = PublicFunctions.UIColorFromRGB(rgbValue: 0xFFE8D6)
            imperialUnitButton.titleLabel?.textColor = UIColor.black
            metricButtonIsWhite = false
            imperialButtonIsWhite = true
        }
    }
    
    @IBAction func metricUnitButtonPressed(_ sender: UIButton) {
        if (metricButtonIsWhite) {
            metricUnitButton.backgroundColor = PublicFunctions.UIColorFromRGB(rgbValue: 0xff971d)
            metricUnitButton.titleLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            imperialUnitButton.backgroundColor = PublicFunctions.UIColorFromRGB(rgbValue: 0xFFE8D6)
            imperialUnitButton.titleLabel?.textColor = UIColor.black
            metricButtonIsWhite = false
            imperialButtonIsWhite = true
        }
    }
    
    @IBAction func imperialUnitButtonPressed(_ sender: UIButton) {
        if (imperialButtonIsWhite) {
            imperialUnitButton.backgroundColor = PublicFunctions.UIColorFromRGB(rgbValue: 0xff971d)
            metricUnitButton.backgroundColor = PublicFunctions.UIColorFromRGB(rgbValue: 0xFFE8D6)
            imperialButtonIsWhite = false
            metricButtonIsWhite = true
        }
    }
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
    }
    
}
