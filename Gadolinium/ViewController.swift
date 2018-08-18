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
    @IBOutlet weak var resultTextField: UILabel!
    
    
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
       
        let dose: String = doseTextField.text ?? ""
        let weight: String = weightTextField.text ?? ""
        
        
        if !dose.isEmpty && !weight.isEmpty {
            resultTextField.text = "yoyo"
        }
        print("jo")
    }
    
    
}

