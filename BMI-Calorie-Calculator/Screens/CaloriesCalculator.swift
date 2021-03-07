//
//  CaloriesCalculator.swift
//  BMI-Calorie-Calculator
//
//  Created by Lucas Berger on 29/1/21.
//

import UIKit

class CaloriesCalculator: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide Keyboard when Taped around
        hideKeyboardWhenTappedAround()
        
        navigationItem.title = "Calories Calculator"
    }
    
}
