import Foundation
import Alamofire

class ParkingRequest {
    class func fetch(url: String, success: (String) -> Void) {
        Alamofire.request(.GET, url).responseString { (_, _, string, _) in
            if let string = string {
                success(string)
            }
        }
    }
}