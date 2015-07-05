import Foundation
import Alamofire
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
        let vanBurenUrl = "http://www.naperville.il.us/parkingfacilities/vanburen.aspx"
        Alamofire.request(.GET, vanBurenUrl).responseString(encoding: nil, completionHandler: parseVanBurenResponse)
        
        let centralUrl = "http://www.naperville.il.us/parkingfacilities/central.aspx"
        Alamofire.request(.GET, centralUrl).responseString(encoding: nil, completionHandler: parseCentralResponse)
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
    
    private func parseCentralResponse(request: NSURLRequest, response: NSHTTPURLResponse?, string: String?, error: NSError?) {
        if let string = string,
            let openRange = string.rangeOfString("<table"),
            let closeRange = string.rangeOfString("</table>") {
                var table = string[openRange.startIndex..<closeRange.endIndex]
                
                while table.rangeOfString("&nbsp;") != nil {
                    if let range = table.rangeOfString("&nbsp;") {
                        table.removeRange(range)
                    }
                }
                
                let xml = SWXMLHash.parse(table)
                
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
}