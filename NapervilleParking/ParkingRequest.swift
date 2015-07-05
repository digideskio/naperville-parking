import Foundation
import Alamofire
import SWXMLHash

class ParkingRequest {
    class func fetch(url: String, success: (String) -> Void) {
        Alamofire.request(.GET, url).responseString { (_, _, string, _) in
            if let string = string {
                success(string)
            }
        }
    }
    
    class func xmlForRange(string: String, open: Range<String.Index>?, close: Range<String.Index>?) -> XMLIndexer? {
        if let open = open, let close = close {
            var haha = string[open.startIndex..<close.endIndex]
            
            while haha.rangeOfString("&nbsp;") != nil {
                if let range = haha.rangeOfString("&nbsp;") {
                    haha.removeRange(range)
                }
            }
            
            return SWXMLHash.parse(haha)
        } else {
            return nil
        }
    }
}