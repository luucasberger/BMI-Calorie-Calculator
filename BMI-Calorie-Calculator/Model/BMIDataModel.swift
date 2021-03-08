//
//  BMIDataModel.swift
//  BMI-Calorie-Calculator
//
//  Created by Lucas Berger on 7/3/21.
//

import UIKit

struct BMIDataModel {
    func calculateBMI(height: Double, weight: Double) -> Double {
        let bmi = (weight / (height * height))
        
        return Double(round(bmi*10))/10
    }
}
