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
        
        
        // Return the configured cell
        return cell
    }

    private func loadContrastAgents() {
        
        guard let contrastAgent1 = ContrastAgent(name: "contrast agent numeral uno", dose: "0.2", concentration: "04", packageInsert: "asdf") else {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let contrastAgent2 = ContrastAgent(name: "contrast agent numeral dose", dose: "0.3", concentration: "03", packageInsert: "fdsa") else {
            fatalError("Unable to instantiate meal1")
        }
        
        contrastAgents += [contrastAgent1, contrastAgent2]
    }
}
