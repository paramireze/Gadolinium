import UIKit
import os.log

class ContrastAgentTableViewController: UITableViewController {
    
    var contrastAgents = [ContrastAgent]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLogo()   
        loadDefaultContrastAgents()
        tableView.rowHeight = 90
        showDisclaimer()
        
    }
    
    func showDisclaimer() {
        let title = "Disclaimer"
        let message = "The results obtained with the Gadolinium Dose Calculator are intended to serve solely as guidelines for physicians and MRI technicians and should be considered as indicative only. The use of the calculator should not in any way substitute for the evaluation of a qualified physician. radiology.wisc.edu and/or the Board of Regents of the University of Wisconsin System, its officers, employees, and agents cannot be held responsible for the reliability of any results provided by the use of the calculator. The calculator may give inaccurate results due to the insertion of inaccurate data by the user, by a technical error within the application at the moment of calculation, or other unforeseen circumstances."
        
        alert(title: title, message: message)
    }
    
    func alert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contrastAgents.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create an object of the dynamic cell "PlainCell"
        
        let cellIdentifier = "ContrastAgentTableViewCell"
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ContrastAgentTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ContrastAgentTableViewCell.")
        }
        
        let contrastAgent =  contrastAgents[indexPath.row]
        
        cell.contrastAgentNameLabel.text = contrastAgent.name
        cell.contrastAgentDoseLabel.text = "Dose: " + contrastAgent.dose + " " + contrastAgent.doseUnit
        cell.contrastAgentConcentrationLabel.text = "Conc: " +  contrastAgent.concentration + " " + contrastAgent.concentrationUnit
        
        // Return the configured cell
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let contrastAgentViewController = segue.destination as? ViewController else {
            fatalError("Unexpected Destination: \(segue.destination)")
        }
        
        guard let selectedContrastAgentCell = sender as? ContrastAgentTableViewCell else {
            fatalError("Unexpected sender: \(sender)")
        }
        
        guard let indexPath = tableView.indexPath(for: selectedContrastAgentCell) else {
            fatalError("The selected cell is not being displayed by the table")
        }
        
        let selectedContrastAgent = contrastAgents[indexPath.row]
        contrastAgentViewController.contrastAgent = selectedContrastAgent
    }
    
    
    private func loadDefaultContrastAgents() {
        
        guard let gadobenateDimeglumine = ContrastAgent(
            name: "gadobenate dimeglumine (MultiHance)",
            concentration: "0.5",
            concentrationUnit: "M",
            dose: "0.1",
            doseUnit: "mmol/kg",
            notes: nil,
            packageInsert: "https://medlibrary.org/lib/rx/meds/multihance-1/") else {
                fatalError("Failed To Load ")
        }
        
        guard let gadoxecticAcid = ContrastAgent(
            name: "gadoxectic acid (Eovist)",
            concentration: "0.25",
            concentrationUnit: "M",
            dose: "0.25",
            doseUnit: "mmol/kg",
            notes: "UW standard dose differs from package insert. Eovist dose at UW is 2x package insert, and is an off-label dose.",
            packageInsert: "https://medlibrary.org/lib/rx/meds/eovist/") else {
                fatalError("")
        }
        
        guard let gadofosvesetTrisodium = ContrastAgent(
            name: "gadofosveset trisodium (Ablavar)",
            concentration: "0.25",
            concentrationUnit: "M",
            dose: "0.03",
            doseUnit: "mmol/kg",
            notes: nil,
            packageInsert: "https://medlibrary.org/lib/rx/meds/ablavar/") else {
                fatalError("")
        }

        guard let gadoterateMeglumine = ContrastAgent(
            name: "gadoterate meglumine (Dotarem)",
            concentration: "0.5",
            concentrationUnit: "M",
            dose: "0.1",
            doseUnit: "mmol/kg",
            notes: nil,
            packageInsert: "https://medlibrary.org/lib/rx/meds/dotarem/") else {
                fatalError("")
        }
 
        guard let gadoteridol = ContrastAgent(
            name: "gadoteridol (Prohance)",
            concentration: "0.5",
            concentrationUnit: "M",
            dose: "0.1",
            doseUnit: "mmol/kg",
            notes: nil,
            packageInsert: "https://medlibrary.org/lib/rx/meds/prohance-1/") else {
                fatalError("")
        }
        
        guard let gadopentatateDimeglumine = ContrastAgent(
            name: "gadopentatate dimeglumine (Magnevist)",
            concentration: "0.5",
            concentrationUnit: "M",
            dose: "0.1",
            doseUnit: "mmol/kg",
            notes: nil,
            packageInsert: "https://medlibrary.org/lib/rx/meds/magnevist-1/") else {
            fatalError("")
        }
        
        guard let gadodiamide = ContrastAgent(
            name: "gadodiamide (Omniscan)",
            concentration: "0.5",
            concentrationUnit: "M",
            dose: "0.1",
            doseUnit: "mmol/kg",
            notes: nil,
            packageInsert: "https://medlibrary.org/lib/rx/meds/omniscan/") else {
                fatalError("")
        }
 
        guard let gadoversetamide = ContrastAgent(
            name: "gadoversetamide (Optimark)",
            concentration: "0.5",
            concentrationUnit: "M",
            dose: "0.1",
            doseUnit: "mmol/kg",
            notes: nil,
            packageInsert: "https://medlibrary.org/lib/rx/meds/optimark-1/") else {
                fatalError("")
        }
        
        guard let gadobutrol = ContrastAgent(
            name: "gadobutrol (Gadavist)",
            concentration: "1",
            concentrationUnit: "M",
            dose: "0.1",
            doseUnit: "mmol/kg",
            notes: nil,
            packageInsert: "https://medlibrary.org/lib/rx/meds/gadavist-1/") else {
                fatalError("")
        }
        
        guard let ferumoxytol = ContrastAgent(
            name: "ferumoxytol (Feraheme)",
            concentration: "30",
            concentrationUnit: "mg/ml",
            dose: "3",
            doseUnit: "mg/kg",
            notes: "The use of ferumoxytol for MRI is an off-label use of this agent. The standard dose at UW for this off-label application is 3.0 mg/kg.",
            packageInsert: "https://medlibrary.org/lib/rx/meds/feraheme-1/") else {
                fatalError("")
        }
        
        contrastAgents += [gadobenateDimeglumine, gadoxecticAcid, gadofosvesetTrisodium, gadoterateMeglumine, gadoteridol, gadopentatateDimeglumine, gadodiamide, gadoversetamide, gadobutrol, ferumoxytol]
    }
    
    private func loadContrastAgents() -> [ContrastAgent]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: ContrastAgent.ArchiveURL.path) as? [ContrastAgent]
    }
    
    func addLogo() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        
        let image = UIImage(named: "Crest")?.withRenderingMode(.alwaysOriginal)
        imageView.image = image
        
        let logo = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.plain, target: self, action: nil)
        
        self.navigationItem.rightBarButtonItem = logo
        
    }
}
