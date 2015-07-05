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
    
    func update() {
        VanBurenRequest.fetch(parseVanBurenResponse)
        CentralRequest.fetch(parseCentralResponse)
    }
    
    private func parseVanBurenResponse(xml: XMLIndexer) {
        if let count = xml["span"].element?.text {
            self.vanBurenCount = count
        }
        
        self.delegate?.didUpdateCounts(self)
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
        
        self.delegate?.didUpdateCounts(self)
    }
}