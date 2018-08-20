//
//  ViewController.swift
//  Gadolinium
//
//  Created by Ramirez Paul E on 7/29/18.
//  Copyright © 2018 Ramirez Paul E. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: -- IBOutputs
    

    
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var doseTextField: UITextField!
    @IBOutlet weak var resultTextField: UILabel!

    @IBOutlet weak var equationLabel: UILabel!
    
    override func viewDidLoad() {
        print("view did infact load")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: --IBActions
    @IBAction func doseTextChange(_ sender: Any) {
        
        // get text field values
        let dose: Int? = Int(doseTextField.text!) ?? 0
        let weight: Int? = Int(weightTextField.text!) ?? 0
        
        // calculate
        let result: Int = calculateDose( dose: dose!, weight: weight!)
        
        // populate labels
        populateLabels(dose: dose!, weight: weight!, result: result)
        
        // dismiss keyboard
        resignFirstResponder()
    }
    
    @IBAction func weightTextChange(_ sender: Any) {
        let dose: Int? = Int(doseTextField.text!) ?? 0
        let weight: Int? = Int(weightTextField.text!) ?? 0
        let result: Int = calculateDose( dose: dose!, weight: weight!)
        
        populateLabels(dose: dose!, weight: weight!, result: result)
    }
    
    func calculateDose(dose: Int, weight: Int) -> Int {
        let result : Int = dose * weight
        return result
    }
    
    func populateLabels(dose: Int, weight: Int, result: Int) {
        let doseText = String(dose)
        let weightText = String(weight)
        let resultText = String(result)
        
        resultTextField.text = resultText
        equationLabel.text = "(" + doseText + " x " + weightText + ")"
    }
}

