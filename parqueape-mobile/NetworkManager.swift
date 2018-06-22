
import Foundation
import Alamofire
import Reachability

typealias CompletionBlock = (Bool, Dictionary<String,AnyObject>) ->Void

class NetworkManager{
    
    static let sharedInstance = NetworkManager()
    
    class func isConnectedToNetwork() -> Bool{
        let reachability: Reachability = Reachability.init()!
        
        if(reachability.connection == .none){
            return false
        }else{
            return true
        }
    }
    
    func callUrlWithCompletion(url: String!, params: [String: AnyObject]?,
                               completion: @escaping CompletionBlock, method: HTTPMethod){
        let urlString = url
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "TokenHeader" : ""
        ]
        
        Alamofire.request(urlString!, method: method, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON{
            response in
            
            print(response.response?.statusCode as Any)
            
            if(response.response?.statusCode == 200){
                print(response.result.value as Any)
                completion(true, response.result.value as! Dictionary)
            }else{
                completion(false, Dictionary<String,AnyObject>())
            }
        }
        
    }
    
}
