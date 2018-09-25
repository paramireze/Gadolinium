import UIKit
import os.log

class ContrastAgentTableViewController: UITableViewController {
    
    var contrastAgents = [ContrastAgent]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContrastAgents()
        tableView.rowHeight = 90
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
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        // Depending on the section, fill the textLabel with the relevant text
       
        let asdf =  contrastAgents[indexPath.row]
        
        cell.contrastAgentNameLabel.text = asdf.name
        cell.contrastAgentDoseLabel.text = "Dose: " + asdf.dose + " mmol/kg"
        cell.contrastAgentConcentrationLabel.text = "Conc: " +  asdf.concentration + " M"
        
        // Return the configured cell
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        
    }
    
    
    private func loadContrastAgents() {
        
        guard let contrastAgent1 = ContrastAgent(name: "Contrast Agent Numeral Uno", dose: "0.2", concentration: "0.4", packageInsert: "asdf") else {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let contrastAgent2 = ContrastAgent(name: "Contrast Agent Numeral Dose", dose: "0.3", concentration: "0.5", packageInsert: "fdsa") else {
            fatalError("Unable to instantiate meal1")
        }
        
        contrastAgents += [contrastAgent1, contrastAgent2]
    }
}
