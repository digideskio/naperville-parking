import UIKit

class ViewController: UIViewController {
    let parkingSpotStore = ParkingSpotStore()
    
    @IBOutlet weak var jeffersonUpperLabel: UILabel!
    @IBOutlet weak var chicagoMiddleLabel: UILabel!
    @IBOutlet weak var jeffersonLowerLabel: UILabel!
    @IBOutlet weak var vanBurenLabel: UILabel!

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
    }
}