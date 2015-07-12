import UIKit

class ViewController: UIViewController {
    let parkingSpotStore = ParkingSpotStore()
    
    var dateFormatter: NSDateFormatter {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter
    }
    
    @IBOutlet weak var jeffersonUpperLabel: UILabel!
    @IBOutlet weak var chicagoMiddleLabel: UILabel!
    @IBOutlet weak var jeffersonLowerLabel: UILabel!
    @IBOutlet weak var vanBurenLabel: UILabel!
    @IBOutlet weak var lastUpdatedLabel: UILabel!
    
    @IBAction func refreshButtonPressed(sender: AnyObject) {
        parkingSpotStore.update()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        parkingSpotStore.delegate = self
        parkingSpotStore.update()
    }
}

extension ViewController: ParkingSpotStoreDelegate {
    func didUpdateCounts(store: ParkingSpotStore) {
        self.vanBurenLabel.text = store.vanBurenCount
        self.jeffersonUpperLabel.text = store.jeffersonUpperCount
        self.chicagoMiddleLabel.text = store.chicagoMiddleCount
        self.jeffersonLowerLabel.text = store.jeffersonLowerCount
        
        let updatedAt = dateFormatter.stringFromDate(store.lastUpdated!)
        self.lastUpdatedLabel.text = "As Of: \(updatedAt)"
    }
}