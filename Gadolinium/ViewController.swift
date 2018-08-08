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
    @IBOutlet weak var doseTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: --IBActions
    @IBAction func calculateDoseWeight(_ sender: Any) {
        print("yo")
        guard let dose = doseTextField.text, !dose.isEmpty else {
            return
        }
        
        guard let weight = weightTextField.text, !weight.isEmpty else {
            return
        }
        print("jo")
    }
    
    @IBAction func calculateDoseWeightChange(_ sender: Any) {
        print("yo2")
        guard let dose = doseTextField.text, !dose.isEmpty else {
            return
        }
        
        guard let weight = weightTextField.text, !weight.isEmpty else {
            return
        }
        print("jo2")
    }
}

