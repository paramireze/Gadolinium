import UIKit

class ContrastAgent {
    
    var name: String
    var concentration: String
    var concentrationUnit: String
    var dose: String
    var doseUnit: String
    var notes: String
    var packageInsert: String
    
    init?(name: String, concentration: String, concentrationUnit: String, dose: String, doseUnit: String, notes: String?, packageInsert:String) {
        
        // Required fields
        guard !name.isEmpty else{
            return nil
        }
        
        guard !concentration.isEmpty else {
            return nil
        }
        
        guard !concentrationUnit.isEmpty else {
            return nil
        }
        
        guard !dose.isEmpty else{
            return nil
        }
        
        guard !doseUnit.isEmpty else {
            return nil
        }
        
        guard !(notes?.isEmpty)! else {
            return nil
        }
        
        guard !(packageInsert.isEmpty) else {
            return nil
        }
        
        //Initialize stored properties
        self.name = name
        self.concentration = concentration
        self.concentrationUnit = concentrationUnit
        self.dose = dose
        self.doseUnit = doseUnit
        self.notes = notes!
        self.packageInsert = (packageInsert)
    }
}
