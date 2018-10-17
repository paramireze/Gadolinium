import UIKit
import os.log

class ContrastAgent: NSObject, NSCoding  {
    
    var name: String
    var concentration: String
    var concentrationUnit: String
    var dose: String
    var doseUnit: String
    var notes: String?
    var packageInsert: String
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(concentration, forKey: PropertyKey.concentration)
        aCoder.encode(concentrationUnit, forKey: PropertyKey.concentrationUnit)
        aCoder.encode(dose, forKey: PropertyKey.dose)
        aCoder.encode(doseUnit, forKey: PropertyKey.doseUnit)
        aCoder.encode(notes, forKey: PropertyKey.notes)
        aCoder.encode(packageInsert, forKey: PropertyKey.packageInsert)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a contrast agent object.", log: OSLog.default, type: .debug)
            return nil
        }
    
        // Because photo is an optional property of Meal, just use conditional cast.
        let concentration = aDecoder.decodeObject(forKey: PropertyKey.concentration)
        let concentrationUnit = aDecoder.decodeObject(forKey: PropertyKey.concentrationUnit)
        let dose = aDecoder.decodeObject(forKey: PropertyKey.dose)
        let doseUnit = aDecoder.decodeObject(forKey: PropertyKey.doseUnit)
        let notes = aDecoder.decodeObject(forKey: PropertyKey.notes) as? String
        let packageInsert = aDecoder.decodeObject(forKey: PropertyKey.packageInsert)
        
        // Must call designated initializer.
        self.init(name: name, concentration: concentration as! String, concentrationUnit: concentrationUnit as! String, dose: dose as! String, doseUnit: doseUnit as! String, notes: notes, packageInsert: packageInsert as! String)
    }
    
    struct PropertyKey {
        static let name = "name"
        static let concentration = "concentration"
        static let concentrationUnit = "concentrationUnit"
        static let dose = "dose"
        static let doseUnit = "doseUnit"
        static let notes = "notes"
        static let packageInsert = "packageInsert"
    }
   
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
        
        guard !(packageInsert.isEmpty) else {
            return nil
        }
        
        //Initialize stored properties
        self.name = name
        self.concentration = concentration
        self.concentrationUnit = concentrationUnit
        self.dose = dose
        self.doseUnit = doseUnit
        self.notes = notes
        self.packageInsert = (packageInsert)
    }
}
