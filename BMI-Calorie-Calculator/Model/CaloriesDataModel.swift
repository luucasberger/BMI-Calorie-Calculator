//
//  CaloriesDataModel.swift
//  BMI-Calorie-Calculator
//
//  Created by Lucas Berger on 7/3/21.
//

import UIKit

struct CaloriesDataModel {
    var exerciseLevels: [String] = ["", "Little or no exercise", "Light exercise/sports 1-3 days/week", "Moderate exercise/sports 3-5 days/week", "Hard exercise/sports 6-7 days/week", "Very intense exercise daily, or physical job"]
    var activityMultipliers: [Double] = [0.0, 1.2, 1.375, 1.55, 1.725, 1.9]
    
    var genders: [String] = ["", "Male", "Female"]
    
    var ages: [String] = { () -> [String] in
        var i = 0
        var res: [String] = []
        res.append("")
        while i < 122 {
            i += 1
            if i == 1 {
                res.append("\(String(i))")
            } else {
                res.append("\(String(i))")
            }
        }
        return res
    }()
    
    func calculateBMR(weight: Double, height: Double, age: Double, gender: String) -> Int {
        var bmr: Double!
        if gender == "Male" {
            /*
             BMR for Men = 66.47 + (13.75 * weight [kg]) + (5.003 * size [cm]) − (6.755 * age [years])
             */
            bmr = round((66.47 + (13.75*weight) + (5.003*height) - (6.755*age)))
        } else {
            /*
             BMR for Women = 655.1 + (9.563 * weight [kg]) + (1.85 * size [cm]) − (4.676 * age [years])
             */
            bmr = round((655.1 + (9.563*weight) + (1.85*height) - (4.676*age)))
        }
        
        return Int(bmr)
    }
    
    func totalCalorieNeeds(bmr: Double, multiplier: Double) -> Int {
        let calorieNeeds = bmr*multiplier
        return Int(round(calorieNeeds))
    }
}
