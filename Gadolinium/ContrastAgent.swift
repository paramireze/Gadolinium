import UIKit

class ContrastAgent {
    
    var dose: String
    var concentration: String
    var packageInsert: String
    
    init?(dose: String, concentration: String, packageInsert:String?) {
        
        // Required fields
        guard !dose.isEmpty else{
            return nil
        }
        
        guard !concentration.isEmpty else {
            return nil
        }
        
        //Initialize stored properties
        self.dose = dose
        self.concentration = concentration
        self.packageInsert = (packageInsert)!
    }
}
