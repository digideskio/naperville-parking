import Foundation
import SWXMLHash

protocol ParkingSpotStoreDelegate {
    func didUpdateCounts(store: ParkingSpotStore)
}

class ParkingSpotStore {
    var delegate: ParkingSpotStoreDelegate?
    
    var jeffersonUpperCount = ""
    var chicagoMiddleCount = ""
    var jeffersonLowerCount = ""
    var vanBurenCount = ""
    
    var lastUpdated: NSDate?
    
    func update() {
        VanBurenRequest.fetch(parseVanBurenResponse)
    }
    
    private func parseVanBurenResponse(xml: XMLIndexer) {
        if let count = xml["span"].element?.text {
            self.vanBurenCount = count
        }
        
        CentralRequest.fetch(parseCentralResponse)
    }
    
    private func parseCentralResponse(xml: XMLIndexer) {
        if let count = xml["table"]["tr"][1]["td"][1]["p"]["span"].element?.text {
            self.jeffersonUpperCount = count
        }
        
        if let count = xml["table"]["tr"][3]["td"][1]["p"]["span"].element?.text {
            self.chicagoMiddleCount = count
        }
        
        if let count = xml["table"]["tr"][5]["td"][1]["p"]["span"].element?.text {
            self.jeffersonLowerCount = count
        }
        
        lastUpdated = NSDate()
        
        self.delegate?.didUpdateCounts(self)
    }
}