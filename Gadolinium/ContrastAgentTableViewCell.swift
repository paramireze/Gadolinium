import UIKit

class ContrastAgentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contrastAgentNameLabel: UILabel!
    @IBOutlet weak var contrastAgentConcentrationLabel: UILabel!
    @IBOutlet weak var contrastAgentDoseLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
