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
    
    //MARK: --IBOutputs
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var doseTextField: UITextField!
    @IBOutlet weak var resultTextField: UILabel!
    @IBOutlet weak var equationLabel: UILabel!
    @IBOutlet weak var doseInfoTextArea: UILabel!
    @IBOutlet weak var formulaLabel: UILabel!
    @IBOutlet weak var lbsButton: UIButton!
    @IBOutlet weak var kgButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        initializeToolbar()
        toggleLabels(value: true)
    }
    
    func toggleLabels(value: Bool) {
        formulaLabel.isHidden = value
        doseInfoTextArea.isHidden = value
        formulaLabel.isHidden = value
        setButtonColors(isLbsSelected: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func selectLbs(_ sender: Any) {
        setButtonColors(isLbsSelected: true)
    }
    
    @IBAction func selectKgs(_ sender: Any) {
        setButtonColors(isLbsSelected: false)
    }
    
    //MARK: --IBActions for Dose
    @IBAction func dostTextBegin(_ sender: Any) {
        toolBar.isHidden = false
    }
    
    @IBAction func doseTextExit(_ sender: Any) {
        toolBar.isHidden = true
        
    }
    
    @IBAction func doseTextChange(_ sender: Any) {
        
        toggleLabels(value: false)
        
        // get text field values
        let dose: Double? = Double(doseTextField.text!) ?? 0
        let weight: Double? = Double(weightTextField.text!) ?? 0
        
        // calculate
        let result: Double = calculateDose( dose: dose!, weight: weight!)
        
        // populate labels with dose calculation
        populateLabels(dose: dose!, weight: weight!, result: result)
        
        // only display toolbar if valid input
    }
    
    //MARK: --IBActions for Weight
    @IBAction func weightTextBegin(_ sender: Any) {
        toolBar.isHidden = false
    }
    
    @IBAction func weightTextExit(_ sender: Any) {
        toolBar.isHidden = true
    }
    
    @IBAction func weightTextChange(_ sender: Any) {
        
        toggleLabels(value: false)
        
        
        // get text field values
        let dose: Double? = Double(doseTextField.text!) ?? 0
        let weight: Double? = Double(weightTextField.text!) ?? 0
        
        // calculate
        let result: Double = calculateDose( dose: dose!, weight: weight!)
        
        // populate labels with dose calculation
        populateLabels(dose: dose!, weight: weight!, result: result)
    }
    
    //MARK: --Functions & Helper Methods
    func initializeToolbar() {
        print(UIApplication.shared.statusBarFrame.height)//44 for iPhone x, 20 for other iPhones
        navigationController?.navigationBar.barTintColor = .red
        
        
        var items = [UIBarButtonItem]()
        items.append(
            UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: nil)
        )
        
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
    
    func calculateDose(dose: Double, weight: Double) -> Double {
        let result : Double = dose * weight
        return result
    }
    
    func populateLabels(dose: Double, weight: Double, result: Double) {
        let doseText = String(dose)
        let weightText = String(weight)
        let resultText = String(result)
        
        resultTextField.text = resultText
        equationLabel.text = "(" + doseText + " x " + weightText + ")"
        
    }
    
    func toggleToolbar(doseTextField: String, weightTextField: String) {
        if (!doseTextField.isEmpty && !weightTextField.isEmpty) {
            toolBar.isHidden = false
        } else {
            toolBar.isHidden = true
        }
    }
    
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
    
    func setButtonColors(isLbsSelected: Bool = true) {
        
        if (isLbsSelected) {
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
}

