//
//  ViewController.swift
//  Gadolinium
//
//  Created by Ramirez Paul E on 7/29/18.
//  Copyright © 2018 Ramirez Paul E. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: --Variables
    let toolBar = UIToolbar()
    
    var weightUnitConversion: Double!
    var concentration: Double!
    
    //MARK: --IBOutputs
    @IBOutlet weak var doseUnitLabel: UILabel!
    @IBOutlet weak var contrastAgentNameLabel: UILabel!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var doseTextField: UITextField!
    @IBOutlet weak var resultTextField: UILabel!
    @IBOutlet weak var equationLabel: UILabel!
    @IBOutlet weak var doseInfoTextArea: UILabel!
    @IBOutlet weak var formulaLabel: UILabel!
    @IBOutlet weak var lbsButton: UIButton!
    @IBOutlet weak var kgButton: UIButton!
    
    
    var contrastAgent: ContrastAgent?

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for:segue, sender: sender)
    }
    
    //MARK: --IBActions
    @IBAction func selectLbs(_ sender: Any) {
        lbsButton.isSelected = true
        kgButton.isSelected = false
        setButtonColors()
        setWeightUnit()
        formSubmit()
    }
    
    @IBAction func selectKgs(_ sender: Any) {
        lbsButton.isSelected = false
        kgButton.isSelected = true
        setButtonColors()
        setWeightUnit()
        formSubmit()
    }
    
    @IBAction func dostTextBegin(_ sender: Any) {
        // do stuff unless you don't want to
    }
    
    @IBAction func doseTextExit(_ sender: Any) {
        formSubmit()
    }
    
    @IBAction func weightTextBegin(_ sender: Any) {
        // do not do stuff
    }
    
    @IBAction func weightTextExit(_ sender: Any) {
        formSubmit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
            resignFirstResponders()
        
        if let contrastAgent = contrastAgent {
            
            var contrastAgentString = contrastAgent.name
            
            if (contrastAgent.notes != nil) {
                contrastAgentString += "\n " + contrastAgent.notes!
            }
            
            contrastAgentNameLabel.text = contrastAgentString
            doseTextField.text = contrastAgent.dose
            concentration = Double(contrastAgent.concentration)
            doseUnitLabel.text = contrastAgent.doseUnit
        }
        
        // lets get started
        addLogo()
        hideLabels(value: true)
        selectWeightUnit()
        setWeightUnit()
        setButtonColors()
        lbsButton.layer.cornerRadius = 4
        kgButton.layer.cornerRadius = 4
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addLogo() {
        let nav = self.navigationController?.navigationBar
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        
        let image = UIImage(named: "Crest")?.withRenderingMode(.alwaysOriginal)
        imageView.image = image
        
        let logo = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.plain, target: self, action: nil)
        
        self.navigationItem.rightBarButtonItem = logo
        
    }
    
    func setWeightUnit() {
        weightUnitConversion = isLbsSelected() ? 0.453592 : 1.0
    }
    
    func getWeightMultipliedByWeightUnit() -> Double {
        let weight: Double? = getWeight()
        let result = weight! * weightUnitConversion!
        return round(result * 100) / 100
    }

    func displayResult(dose: Double, weight: Double) {
        
        let result = round(dose * (weight * weightUnitConversion) / concentration)
        
        resultTextField.text = String(result) + " ml"
    }
    
    func showFormula(dose: Double, weight: Double) {
        
        let doseText = String(dose)
        let weightText = String(getWeightMultipliedByWeightUnit())
        let concentrationText = String(concentration)
        
        equationLabel.text = "(" + doseText + " mmol/kg * " + weightText + " kgs) / " + concentrationText + " mmol/ml"
    }
    

    func hideLabels(value: Bool) {
        formulaLabel.isHidden = value
        doseInfoTextArea.isHidden = value
        
        if value {
            resultTextField.text = ""
            equationLabel.text = ""
        }
    }
    
    func resignFirstResponders() {
        weightTextField.resignFirstResponder()
        doseTextField.resignFirstResponder()
    }

    func getDose() -> Double {
        let dose: Double? = Double(doseTextField.text!) ?? 0
        return dose!
    }
    
    func getWeight() -> Double {
        let weight: Double? = Double(weightTextField.text!) ?? 0
        return weight!
    }
    
    func selectWeightUnit() {
        if !isLbsSelected() && !isKgSelected() {
            lbsButton.isSelected = true
        }
    }
    
    func isLbsSelected() -> Bool {
        return lbsButton.isSelected == true
    }
    
    func isKgSelected() -> Bool {
        return kgButton.isSelected == true
    }
    
    func setButtonColors() {
        
        if (isLbsSelected()) {
            lbsButton.backgroundColor = hexStringToUIColor(hex: "C5050C")
            lbsButton.setTitleColor(UIColor.white, for: .normal)

            kgButton.backgroundColor = UIColor.white
            kgButton.setTitleColor(UIColor.black, for: .normal)
            
        } else {
            kgButton.backgroundColor = hexStringToUIColor(hex: "C5050C")
            kgButton.setTitleColor(UIColor.white, for: .normal)

            lbsButton.backgroundColor = UIColor.white
            lbsButton.setTitleColor(UIColor.black, for: .normal)
        }
    }
    
    //MARK: --Useful Functions & Helper Methods found from the web
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    @objc func formSubmit () {
        let dose: Double? = getDose()
        let weight: Double? = getWeight()
        print(weight!)
        
        if (isInValidInput(input: weight!)) {
            hideLabels(value: true)
        } else {
            setWeightUnit()
            displayResult(dose: dose!, weight: weight!)
            showFormula(dose: dose!, weight: weight!)
            hideLabels(value: false)
        }
    
    }
    
    func isInValidInput(input: Double) -> Bool {
        var isInvalidInput = true
        
        if (input != 0) {
            isInvalidInput = false
        } else {
            if (doseTextField.text != "" && weightTextField.text != "") {
                alert(title: "Invalid Input", message: "Please use numbers or decimal points only")
            }
        }
        
        return isInvalidInput
    }
    
    func alert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
}

