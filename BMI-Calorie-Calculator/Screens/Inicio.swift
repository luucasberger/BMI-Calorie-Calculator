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
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 0.9274820685, blue: 0.8697011471, alpha: 1)
        navigationItem.title = "Fitness Calculator"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Lastica", size: 20.0)!, .foregroundColor: PublicFunctions.UIColorFromRGB(rgbValue: 0x000000)]
        print("Loaded")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // navigationBar title size turned back '20.0'.
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Lastica", size: 20.0)!, .foregroundColor: PublicFunctions.UIColorFromRGB(rgbValue: 0x000000)]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationItem.backButtonTitle = ""
        // Reduced navigationBar title size to '19.0', so that it fits on every iPhone Screen.
        if (segue.identifier == "CaloriesToCalculator") {
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Lastica", size: 19.0)!, .foregroundColor: PublicFunctions.UIColorFromRGB(rgbValue: 0x000000)]
        }
    }
    
}
