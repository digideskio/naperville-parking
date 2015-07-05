import UIKit

class ViewController: UIViewController {
    let parkingSpotStore = ParkingSpotStore()
    
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
    }
}