import Foundation
import SWXMLHash

class CentralRequest: ParkingRequest {
    class func fetch(success: (XMLIndexer) -> Void) {
        let url = "http://www.naperville.il.us/parkingfacilities/central.aspx"
        
        super.fetch(url) { string in
            let openRange = string.rangeOfString("<table")
            let closeRange = string.rangeOfString("</table>")
            
            if let xml = self.xmlForRange(string, open: openRange, close: closeRange) {
                success(xml)
            }
        }
    }
}