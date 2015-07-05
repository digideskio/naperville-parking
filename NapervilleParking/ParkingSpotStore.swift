import Foundation
import Alamofire
import SWXMLHash

protocol ParkingSpotStoreDelegate {
    func didUpdateCounts(store: ParkingSpotStore)
}

class ParkingSpotStore {
    var delegate: ParkingSpotStoreDelegate?
    var vanBurenCount = ""
    
    func update() {
        let url = "http://www.naperville.il.us/parkingfacilities/vanburen.aspx"
        Alamofire.request(.GET, url).responseString(encoding: nil, completionHandler: parseVanBurenResponse)
    }
    
    private func parseVanBurenResponse(request: NSURLRequest, response: NSHTTPURLResponse?, string: String?, error: NSError?) {
        if let string = string,
            let openRange = string.rangeOfString("<span"),
            let closeRange = string.rangeOfString("</span>") {
                let span = string[openRange.startIndex..<closeRange.endIndex]
                let xml = SWXMLHash.parse(span)
                
                if let count = xml["span"].element?.text {
                    self.vanBurenCount = count
                }
                
                self.delegate?.didUpdateCounts(self)
        }
    }
}