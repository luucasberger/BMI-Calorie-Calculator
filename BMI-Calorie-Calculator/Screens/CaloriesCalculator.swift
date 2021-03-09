//
//  CaloriesCalculator.swift
//  BMI-Calorie-Calculator
//
//  Created by Lucas Berger on 29/1/21.
//

import UIKit

class CaloriesCalculator: UIViewController, UITextFieldDelegate {
    @IBOutlet var heightInput1: UITextField!
    @IBOutlet var heightInput2: UITextField!
    @IBOutlet var weightInputKg: UITextField!
    @IBOutlet var weightInputLb: UITextField!
    @IBOutlet var imperialUnitButton: UIButton!
    @IBOutlet var metricUnitButton: UIButton!
    @IBOutlet var activityLevelInput: UITextField!
    @IBOutlet var ageInput: UITextField!
    @IBOutlet var genderInput: UITextField!
    @IBOutlet var caloriesResult: UILabel!
    
    var metricUnitIsSelected = false
    var activityLevelPicker = UIPickerView()
    var genderPicker = UIPickerView()
    var agePicker = UIPickerView()
    var data: CaloriesDataModel = CaloriesDataModel()
    var multiplier: Double?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide Keyboard when Taped around
        hideKeyboardWhenTappedAround()
        
        navigationItem.title = "Calories Calculator"
        
        heightInput1.delegate = self
        heightInput2.delegate = self
        weightInputLb.delegate = self
        weightInputKg.delegate = self
        
        activityLevelPicker.delegate = self
        activityLevelPicker.dataSource = self
        activityLevelInput.inputView = activityLevelPicker
        
        agePicker.delegate = self
        agePicker.dataSource = self
        ageInput.inputView = agePicker
        
        genderPicker.delegate = self
        genderPicker.dataSource = self
        genderInput.inputView = genderPicker
        
        setupUIViewController()
    }
    
    func setupUIViewController() {
        heightInput1.keyboardType = .decimalPad
        heightInput2.keyboardType = .decimalPad
        weightInputKg.keyboardType = .decimalPad
        weightInputLb.keyboardType = .decimalPad
        
        weightInputKg.isHidden = true
        
        caloriesResult.text = "0 calories    "
        
        heightInput1.attributedPlaceholder = NSAttributedString(string: "ft",
                                                                attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        heightInput2.attributedPlaceholder = NSAttributedString(string: "in",
                                                                attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        weightInputKg.attributedPlaceholder = NSAttributedString(string: "kg",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        weightInputLb.attributedPlaceholder = NSAttributedString(string: "lb",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        activityLevelInput.attributedPlaceholder = NSAttributedString(string: "Select your activity level",
                                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        ageInput.attributedPlaceholder = NSAttributedString(string: "Enter your age",
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        genderInput.attributedPlaceholder = NSAttributedString(string: "Select your gender",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    
    func resetData() {
        heightInput1.text = ""
        heightInput2.text = ""
        weightInputKg.text = ""
        weightInputLb.text = ""
        activityLevelInput.text = ""
        ageInput.text = ""
        genderInput.text = ""
        
        caloriesResult.text = "0 calories    "
        
        agePicker.selectRow(0, inComponent: 0, animated: true)
        genderPicker.selectRow(0, inComponent: 0, animated: true)
        activityLevelPicker.selectRow(0, inComponent: 0, animated: true)
    }
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        hideKeyboard()
        
        if metricUnitIsSelected {
            if inputsAreValid(inputsToCheck: "Metric") {
                let heightString = PublicFunctions.replaceComaWithDot(in: heightInput1.text!)
                let weightString = PublicFunctions.replaceComaWithDot(in: weightInputKg.text!)
                
                let height = Double(heightString)!
                let weight = Double(weightString)!
                let age = Double(ageInput.text!)!
                let gender = genderInput.text!
                
                let bmr = data.calculateBMR(weight: weight, height: height, age: age, gender: gender)
                caloriesResult.text = "\(data.totalCalorieNeeds(bmr: Double(bmr), multiplier: multiplier!)) calories    "
            } else {
                PublicFunctions.showAlert(in: self)
            }
        } else {
            if inputsAreValid(inputsToCheck: "Imperial") {
                let feetString = heightInput1.text!.replacingOccurrences(of: ",", with: ".")
                let inchesString = heightInput2.text!.replacingOccurrences(of: ",", with: ".")
                let weightString = weightInputLb.text!.replacingOccurrences(of: ",", with: ".")
                
                let height = PublicFunctions.convertFeetToMeters(feet: Double(feetString)!, inches: Double(inchesString)!) * 100
                let weight = PublicFunctions.convertLbToKg(weight: Double(weightString)!)
                let age = Double(ageInput.text!)!
                let gender = genderInput.text!
                
                let bmr = data.calculateBMR(weight: weight, height: height, age: age, gender: gender)
                caloriesResult.text = "\(data.totalCalorieNeeds(bmr: Double(bmr), multiplier: multiplier!)) calories    "
            } else {
                PublicFunctions.showAlert(in: self)
            }
        }
        
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        hideKeyboard()
        
        resetData()
    }
    
    @IBAction func imperialButtonPressed(_ sender: UIButton) {
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
    
    @IBAction func metricButtonPressed(_ sender: UIButton) {
        hideKeyboard()
        
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
    
    func inputsAreValid(inputsToCheck: String) -> Bool {
        var res: Bool = false
        
        if inputsToCheck == "Metric" {
            if (heightInput1.text != "") && (weightInputKg.text != "") && (ageInput.text != "") && (genderInput.text != "") && (activityLevelInput.text != "") {
                let heightString = PublicFunctions.replaceComaWithDot(in: heightInput1.text!)
                let weightString = PublicFunctions.replaceComaWithDot(in: weightInputKg.text!)
                
                let heightCm = Double(heightString)!
                let weightKg = Double(weightString)!
                
                res = (heightCm > 0) && (weightKg > 0)
            }
        } else {
            if (heightInput1.text != "") && (heightInput2.text != "") && (weightInputLb.text != "") && (ageInput.text != "") && (genderInput.text != "") && (activityLevelInput.text != "") {
                let feetString = PublicFunctions.replaceComaWithDot(in: heightInput1.text!)
                let inchesString = PublicFunctions.replaceComaWithDot(in: heightInput2.text!)
                let weightString = PublicFunctions.replaceComaWithDot(in: weightInputLb.text!)
                
                let feet = Double(feetString)!
                let inches = Double(inchesString)!
                let weightLb = Double(weightString)!
                
                res = (feet > 0) && (inches >= 0) && (weightLb > 0)
            }
        }
        return res
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension CaloriesCalculator: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var res: Int!
        
        switch pickerView {
        case activityLevelPicker:
            res = data.exerciseLevels.count
        case agePicker:
            res = data.ages.count
        case genderPicker:
            res = data.genders.count
        default:
            res = 0
        }
        return res
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerView {
        case activityLevelPicker:
            activityLevelInput.text = data.exerciseLevels[row]
            
        case agePicker:
            ageInput.text = data.ages[row]
        case genderPicker:
            genderInput.text = data.genders[row]
        default:
            print("Error in displaying selected input (1)!")
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var res: String!
        
        switch pickerView {
        case activityLevelPicker:
            res = data.exerciseLevels[row]
            multiplier = data.activityMultipliers[row]
        case agePicker:
            res = data.ages[row]
        case genderPicker:
            res = data.genders[row]
        default:
            print("Error in displaying 'titleForRow' inside some UIPickerView!")
        }
        
        return res
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "HelveticaNeueMedium", size: 14)
            pickerLabel?.textAlignment = .center
        }
        switch pickerView {
        case activityLevelPicker:
            pickerLabel?.text = data.exerciseLevels[row]
            multiplier = data.activityMultipliers[row]
        case agePicker:
            pickerLabel?.text = data.ages[row]
        case genderPicker:
            pickerLabel?.text = data.genders[row]
        default:
            print("Error in displaying selected input (2)!")
        }
                
        return pickerLabel!
    }
    
}
