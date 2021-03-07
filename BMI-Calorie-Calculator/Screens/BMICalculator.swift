//
//  BMICalculator.swift
//  BMI-Calorie-Calculator
//
//  Created by Lucas Berger on 29/1/21.
//

import UIKit

class BMICalculator: UIViewController {
    @IBOutlet var bmiResult: UILabel!
    @IBOutlet var imperialUnitButton: UIButton!
    @IBOutlet var metricUnitButton: UIButton!
    @IBOutlet var heightInput1: UITextField!
    @IBOutlet var heightInput2: UITextField!
    @IBOutlet var weightInputKg: UITextField!
    @IBOutlet var weightInputLb: UITextField!
    var metricUnitIsSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide Keyboard when Taped around
        hideKeyboardWhenTappedAround()
        
        navigationItem.title = "BMI Calculator"
        
        
        heightInput1.delegate = self
        weightInputKg.delegate = self
        
        setupUIViewController()
        
    }
    
    func setupUIViewController() {
        heightInput1.keyboardType = .decimalPad
        heightInput2.keyboardType = .decimalPad
        weightInputKg.keyboardType = .decimalPad
        weightInputLb.keyboardType = .decimalPad
        
        weightInputKg.isHidden = true
        
        bmiResult.text = "00.0    "
        
        heightInput1.attributedPlaceholder = NSAttributedString(string: "ft",
                                                                attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        heightInput2.attributedPlaceholder = NSAttributedString(string: "in",
                                                                attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        weightInputKg.attributedPlaceholder = NSAttributedString(string: "kg",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        weightInputLb.attributedPlaceholder = NSAttributedString(string: "lb",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    
    func resetData() {
        heightInput1.text = ""
        heightInput2.text = ""
        weightInputKg.text = ""
        weightInputLb.text = ""
        
        bmiResult.text = "00.0    "
    }
    
    @IBAction func metricUnitPressed(_ sender: UIButton, forEvent event: UIEvent) {
        
        
        if (!metricUnitIsSelected) {
            metricUnitButton.backgroundColor = PublicFunctions.UIColorFromRGB(rgbValue: K.orange)
            metricUnitButton.setTitleColor(.white, for: .normal)
            imperialUnitButton.backgroundColor = PublicFunctions.UIColorFromRGB(rgbValue: K.white)
            imperialUnitButton.setTitleColor(.black, for: .normal)
            
            metricUnitIsSelected = true
            
            resetData()
            
            heightInput1.placeholder = "cm"
            
            UIView.transition(with: heightInput2, duration: 0.4,
                              options: .transitionFlipFromRight,
                              animations: {
                                self.heightInput2.isHidden = true
                                self.weightInputLb.isHidden = true
                                self.weightInputKg.isHidden = false
                              })
        }
        
        
    }
    
    @IBAction func imperialUnitButtonPressed(_ sender: UIButton) {
        hideKeyboard()
        
        if (metricUnitIsSelected) {
            imperialUnitButton.backgroundColor = PublicFunctions.UIColorFromRGB(rgbValue: K.orange)
            imperialUnitButton.setTitleColor(.white, for: .normal)
            metricUnitButton.backgroundColor = PublicFunctions.UIColorFromRGB(rgbValue: K.white)
            metricUnitButton.setTitleColor(.black, for: .normal)
            
            metricUnitIsSelected = false
            
            resetData()
            
            heightInput1.isHidden = true
            
            UIView.transition(with: heightInput2, duration: 0.4,
                              options: .transitionFlipFromLeft,
                              animations: {
                                self.heightInput1.isHidden = false
                                self.heightInput2.isHidden = false
                                self.weightInputKg.isHidden = true
                                self.weightInputLb.isHidden = false
                                
                                self.heightInput1.placeholder = "ft"
                              })
        }
    }
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        hideKeyboard()
        
        if metricUnitIsSelected {
            if inputsAreValid(inputsToCheck: "Metric") {
                let height = Double(heightInput1.text!)! / 100
                let weight = Double(weightInputKg.text!)!
                
                let bmi = (weight / (height * height))
                
                bmiResult.text = "\(Double(round(bmi*10))/10)    "
            } else {
                // create the alert
                let alert = UIAlertController(title: "Not Valid Inputs", message: "Please check if your inputs were written correctly.", preferredStyle: UIAlertController.Style.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            if inputsAreValid(inputsToCheck: "Imperial") {
                let height = convertFeetToMeters(feet: Double(heightInput1.text!)!, inches: Double(heightInput2.text!)!)
                let weight = convertLbToKg(weight: Double(weightInputLb.text!)!)
                print("\(height)")
                let bmi = (weight / (height * height))
                
                bmiResult.text = "\(Double(round(bmi*10))/10)    "
            } else {
                // create the alert
                let alert = UIAlertController(title: "Not Valid Inputs", message: "Please check if your inputs were written correctly.", preferredStyle: UIAlertController.Style.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    /*
     Resets BMI result back to '00.0'.
     */
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        hideKeyboard()
        
        resetData()
    }
    
    func convertFeetToMeters(feet: Double, inches: Double) -> Double {
        var heightCm = (Double(Int(feet)) * 0.3048) + (inches * 0.0254)
        heightCm = Double(round(1000*heightCm)/1000)
        
        return heightCm
    }
    
    func convertLbToKg(weight: Double) -> Double {
        var weightKg = weight * 0.45359237
        weightKg = Double(round(10*weightKg)/10)
        
        return weightKg
    }
    
    func inputsAreValid(inputsToCheck: String) -> Bool {
        var res: Bool = false
        
        if inputsToCheck == "Metric" {
            if (heightInput1.text != "") && (weightInputKg.text != "") {
                let heightCm = Double(heightInput1.text!)!
                let weightKg = Double(weightInputKg.text!)!
                
                res = (heightCm > 0) && (weightKg > 0)
            }
        } else {
            if (heightInput1.text != "") && (heightInput2.text != "") && (weightInputLb.text != "") {
                let feet = Double(heightInput1.text!)!
                let inches = Double(heightInput2.text!)!
                let weightLb = Double(weightInputLb.text!)!
                
                res = (feet > 0) && (inches >= 0) && (weightLb > 0)
            }
        }
        return res
    }
    
    
}

extension BMICalculator: UITextFieldDelegate {
    
    
}
