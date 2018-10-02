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
    }
    
    @IBAction func selectKgs(_ sender: Any) {
        lbsButton.isSelected = false
        kgButton.isSelected = true
        setButtonColors()
        setWeightUnit()
    }
    
    @IBAction func dostTextBegin(_ sender: Any) {
        toolBar.isHidden = false
    }
    
    @IBAction func doseTextExit(_ sender: Any) {
        toolBar.isHidden = true
    }
    
    @IBAction func weightTextBegin(_ sender: Any) {
        toolBar.isHidden = false
    }
    
    @IBAction func weightTextExit(_ sender: Any) {
        toolBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let contrastAgent = contrastAgent {
            contrastAgentNameLabel.text = contrastAgent.name
            doseTextField.text = contrastAgent.dose
            concentration = Double(contrastAgent.concentration)
            doseUnitLabel.text = contrastAgent.doseUnit
        }
        
        // lets get started
        initializeToolbar()
        hideLabels(value: true)
        selectWeightUnit()
        setWeightUnit()
        setButtonColors()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func formSubmit () {
        let dose: Double? = getDose()
        let weight: Double? = getWeight()
        
        setWeightUnit()
        displayResult(dose: dose!, weight: weight!)
        showFormula(dose: dose!, weight: weight!)
        hideLabels(value: false)
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
    
    func calculateDose() -> Double {
        let dose = getDose()
        let result : Double = dose * weightUnitConversion
        return result
    }
    
    func setButtonColors() {
        
        if (isLbsSelected()) {
            lbsButton.backgroundColor = hexStringToUIColor(hex: "FF043A")
            lbsButton.setTitleColor(UIColor.white, for: .normal)

            kgButton.backgroundColor = UIColor.white
            kgButton.setTitleColor(UIColor.black, for: .normal)
            
        } else {
            kgButton.backgroundColor = hexStringToUIColor(hex: "FF043A")
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
    
    func initializeToolbar() {
        
        print(UIApplication.shared.statusBarFrame.height)//44 for iPhone x, 20 for other iPhones
        navigationController?.navigationBar.barTintColor = .white
        
        
        var items = [UIBarButtonItem]()
        
        items.append(
            UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil))
        
        items.append(
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        
        let calculateButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(ViewController.formSubmit))
        
        items.append(calculateButton)
        
        toolBar.isHidden = true
        toolBar.setItems(items, animated: true)
        toolBar.tintColor = .red
        view.addSubview(toolBar)
        
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 11.0, *) {
            let guide = self.view.safeAreaLayoutGuide
            toolBar.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
            toolBar.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
            toolBar.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
            toolBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
            
        }
        else {
            NSLayoutConstraint(item: toolBar, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: toolBar, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: toolBar, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
            
            toolBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        }
    }
}

