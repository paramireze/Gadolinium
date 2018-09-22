import UIKit

class ContrastAgent {
    
    var name: String
    var dose: String
    var concentration: String
    var packageInsert: String
    
    init?(name: String, dose: String, concentration: String, packageInsert:String?) {
        
        // Required fields
        guard !name.isEmpty else{
            return nil
        }
        
        guard !dose.isEmpty else{
            return nil
        }
        
        guard !concentration.isEmpty else {
            return nil
        }
        
        //Initialize stored properties
        self.name = name
        self.dose = dose
        self.concentration = concentration
        self.packageInsert = (packageInsert)!
    }
}
