import Foundation
import SWXMLHash

class VanBurenRequest: ParkingRequest {
    class func fetch(success: (XMLIndexer) -> Void) {
        let url = "http://www.naperville.il.us/parkingfacilities/vanburen.aspx"
        
        super.fetch(url) { string in
            let openRange = string.rangeOfString("<span")
            let closeRange = string.rangeOfString("</span>")
            
            if let xml = self.xmlForRange(string, open: openRange, close: closeRange) {
                success(xml)
            }
        }
    }
}