import UIKit
import os.log

class ContrastAgentTableViewController: UITableViewController {
    
    var contrastAgents = [ContrastAgent]()
    let cellIdentifier = "ContrastAgentTableViewCell"
    var wasEditing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        // dynamically create logo
        addLogo()
        
        // hide toolbar by default unless in edit mode
        self.navigationController?.isToolbarHidden = true
        
        // create toolbar controls
        var items = [UIBarButtonItem]()
        items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil) )
        items.append( UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(undoChanges)))
        self.toolbarItems = items // this made the difference. setting the items to the controller, not the navigationcontroller
        
        // load stored or the default contrast agent settings
        if let savedContrastAgents = loadContrastAgents() {
            contrastAgents += savedContrastAgents
        } else {
            loadDefaultContrastAgents()
        }
        
        // organize contrast agents by sorting using the sortOrder property
        rearrangeContrastAgents()

        // set height
        tableView.rowHeight = 70
        
        // let the world know that this is not a clinical application
        showDisclaimer()
    }
    
    @objc func undoChanges() {
        loadDefaultContrastAgents()
        saveContrastAgents()
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
    
    /*
     default disclaimer message when app opens
    */
    func showDisclaimer() {
        let title = "Disclaimer"
        let message = "The results obtained with the Gadolinium Dose Calculator are intended to serve solely as guidelines for physicians and MRI technicians and should be considered as indicative only. The use of the calculator should not in any way substitute for the evaluation of a qualified physician. radiology.wisc.edu and/or the Board of Regents of the University of Wisconsin System, its officers, employees, and agents cannot be held responsible for the reliability of any results provided by the use of the calculator. The calculator may give inaccurate results due to the insertion of inaccurate data by the user, by a technical error within the application at the moment of calculation, or other unforeseen circumstances."
        
        alert(title: title, message: message)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contrastAgents.count
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create an object of the dynamic cell "PlainCell"
        
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
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {

        if (isEditing) {
            wasEditing = true
            self.navigationController?.isToolbarHidden = false
        } else if (isFinishedEditing()) {
            self.navigationController?.isToolbarHidden = true
            wasEditing = false
            saveContrastAgents()
        }
        
        return true
    }
    
    /*
     check when user clicks the done button
    */
    func isFinishedEditing() -> Bool {
        return !isEditing && wasEditing
    }
    
    /*
     useful method for quick debugging
    */
    func showContrastAgents() {
        
        for contrastAgent in contrastAgents {
        
            print( " sort order: ", contrastAgent.sortOrder, ", name: ", contrastAgent.name)
        }
        
        print("------------ done editing ------------")
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            contrastAgents.remove(at: indexPath.row)
            reassignSortOrder()
            saveContrastAgents()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    /*
     cycle through the contrast agents and reassign sortOrder.
     */
    func reassignSortOrder() {
        
        var newSortOrder = 0
        
        for contrastAgent in contrastAgents {
            contrastAgent.sortOrder = newSortOrder
            newSortOrder = newSortOrder + 1
        }
    }
    
    /*
     rearrange contrast agent list using the sort order property value
    */
    func rearrangeContrastAgents() {
        contrastAgents.sort(by: ( { $0.sortOrder < $1.sortOrder } ))
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
    
    
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt from: IndexPath, to: IndexPath) {

        if from.row < to.row {
            // reference rows that need to be reassigned sort order
            let start = from.row + 1
            let end = to.row
            
            // subtract 1 to the sort order property
            for reorderIndex in start ... end {
                contrastAgents[reorderIndex].sortOrder = contrastAgents[reorderIndex].sortOrder - 1
            }
            
        } else if (from.row > to.row) {
            // reference rows that need to be reassigned sort order
            let start = to.row
            let end = from.row - 1
            
            // add 1 to the sort order property
            for reorderIndex in (start ... end).reversed() {
                contrastAgents[reorderIndex].sortOrder = contrastAgents[reorderIndex].sortOrder + 1
            }
        }
        
        // update the sortOrder of the row the user moved
        if (from.row != to.row) {
            contrastAgents[from.row].sortOrder = to.row
            rearrangeContrastAgents()
        }
       
     }
    
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
     }
    
    // store contrast agent objects to this devices file system
    private func saveContrastAgents() {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(contrastAgents, toFile: ContrastAgent.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Contrast Agent successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save contrast agent...", log: OSLog.default, type: .error)
        }
    }
    
    // grab the contrast agents stored locally on this device
    private func loadContrastAgents() -> [ContrastAgent]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: ContrastAgent.ArchiveURL.path) as? [ContrastAgent]
    }
    
    // dynamically add logo to top right of screen in nav bar
    func addLogo() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        
        let image = UIImage(named: "Crest")?.withRenderingMode(.alwaysOriginal)
        imageView.image = image
        
        let logo = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.plain, target: self, action: nil)
        
        self.navigationItem.rightBarButtonItem = logo
    }
    
    // generate alert
    func alert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func loadDefaultContrastAgents() {
        contrastAgents = [ContrastAgent]()
        
        guard let gadobenateDimeglumine = ContrastAgent(
            name: "gadobenate dimeglumine (MultiHance)",
            sortOrder: 0,
            isHidden: false,
            concentration: "0.5",
            concentrationUnit: "M",
            dose: "0.1",
            maximumDose:"0.2",
            doseUnit: "mmol/kg",
            notes: nil,
            packageInsert: "https://medlibrary.org/lib/rx/meds/multihance-1/") else {
                fatalError("Failed To Load ")
        }
        
        guard let gadoxecticAcid = ContrastAgent(
            name: "gadoxetic acid (Eovist)",
            sortOrder: 1,
            isHidden: false,
            concentration: "0.25",
            concentrationUnit: "M",
            dose: "0.05",
            maximumDose: "0.05",
            doseUnit: "mmol/kg",
            notes: "UW standard dose differs from package insert. Eovist dose at UW is 2x package insert, and is an off-label dose.",
            packageInsert: "http://medlibrary.org/lib/rx/meds/eovist-1/") else {
                fatalError("")
        }
        
        guard let gadoterateMeglumine = ContrastAgent(
            name: "gadoterate meglumine (Dotarem)",
            sortOrder: 2,
            isHidden: false,
            concentration: "0.5",
            concentrationUnit: "M",
            dose: "0.1",
            maximumDose:"0.2",
            doseUnit: "mmol/kg",
            notes: nil,
            packageInsert: "https://medlibrary.org/lib/rx/meds/dotarem/") else {
                fatalError("")
        }
 
        guard let gadoteridol = ContrastAgent(
            name: "gadoteridol (ProHance)",
            sortOrder: 3,
            isHidden: false,
            concentration: "0.5",
            concentrationUnit: "M",
            dose: "0.1",
            maximumDose:"0.2",
            doseUnit: "mmol/kg",
            notes: nil,
            packageInsert: "https://medlibrary.org/lib/rx/meds/prohance-1/") else {
                fatalError("")
        }
        
        guard let gadopentatateDimeglumine = ContrastAgent(
            name: "gadopentetate dimeglumine (Magnevist)",
            sortOrder: 4,
            isHidden: false,
            concentration: "0.5",
            concentrationUnit: "M",
            dose: "0.1",
            maximumDose:"0.2",
            doseUnit: "mmol/kg",
            notes: nil,
            packageInsert: "https://medlibrary.org/lib/rx/meds/magnevist-1/") else {
            fatalError("")
        }
        
        guard let gadodiamide = ContrastAgent(
            name: "gadodiamide (Omniscan)",
            sortOrder: 5,
            isHidden: false,
            concentration: "0.5",
            concentrationUnit: "M",
            dose: "0.1",
            maximumDose: "0.2",
            doseUnit: "mmol/kg",
            notes: nil,
            packageInsert: "https://medlibrary.org/lib/rx/meds/omniscan/") else {
                fatalError("")
        }
        
        guard let gadobutrol = ContrastAgent(
            name: "gadobutrol (Gadavist)",
            sortOrder: 6,
            isHidden: false,
            concentration: "1",
            concentrationUnit: "M",
            dose: "0.1",
            maximumDose: "0.2",
            doseUnit: "mmol/kg",
            notes: nil,
            packageInsert: "https://medlibrary.org/lib/rx/meds/gadavist-1/") else {
                fatalError("")
        }
        
        guard let ferumoxytol = ContrastAgent(
            name: "ferumoxytol (Feraheme)",
            sortOrder: 7,
            isHidden: false,
            concentration: "30",
            concentrationUnit: "mg/ml",
            dose: "3",
            maximumDose:"5.0",
            doseUnit: "mg/kg",
            notes: "The use of ferumoxytol for MRI is an off-label use of this agent. The standard dose at UW for this off-label application is 3.0 mg/kg.",
            packageInsert: "https://medlibrary.org/lib/rx/meds/feraheme-1/") else {
                fatalError("")
        }
        
        contrastAgents += [gadobenateDimeglumine, gadoxecticAcid,  gadoterateMeglumine, gadoteridol, gadopentatateDimeglumine, gadodiamide, gadobutrol, ferumoxytol]
    }
    
}
