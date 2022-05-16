//
//  APIManager.swift
//  Technical Test
//
//  Created by Urvesh on 13/05/22.
//
import UIKit
import Foundation
import Alamofire
import SystemConfiguration
import AVFoundation
import MobileCoreServices
import CommonCrypto


class APIManager: NSObject {
    
    static let sharedInstance = APIManager()
    
    override init() {
        
    }
    
    // MARK: - Check for internet connection
    
    /**
     This method is used to check internet connectivity.
     - Returns: Return boolean value to indicate device is connected with internet or not
     */
    
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    /**
     This method is used to make Alamofire request with or without parameters.
     - Parameters:
     - url: URL of request
     - method: HTTPMethod of request
     - parameter: Parameter of request
     - success: Success closure of method
     - response: Response object of request
     - failure: Failure closure of method
     - error: Failure error
     - connectionFailed: Network connection faild closure of method
     - error: Network error
     */
    
    class func makeRequest(with url: String, method: HTTPMethod, parameter: [String:Any]?, success: @escaping (_ response: Any) -> Void, failure: @escaping (_ error: String) -> Void, connectionFailed: @escaping (_ error: String) -> Void) {
        
        if(isConnectedToNetwork()) {
            if let param = parameter, let data = try? JSONSerialization.data(withJSONObject: param, options: .prettyPrinted) {
                print("=====================POST URL:\(url)=====================")
                print(String(data: data, encoding: .utf8) ?? "Nil Param")
            }
            let headers: HTTPHeaders = [:]

            if method == .get {
                AF.request(url, method: .get, headers: headers).responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let jsonValue = try JSONSerialization.jsonObject(with: data)
                            success(jsonValue)
                        } catch {
                            
                            print("Response of \(url):\n \(String(data: data, encoding: .utf8) ?? "")")
                            print(error.localizedDescription)
                            print(error)
                            failure(error.localizedDescription)
                        }
                    case .failure(let error):
                        print("Response of \(url):\n \(error.localizedDescription)")
                        print(error.localizedDescription)
                        print(error)
                        failure(error.localizedDescription)
                    }
                }
            }
            else{
                AF.request(url, method: method, parameters: parameter, headers: headers).responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let jsonValue = try JSONSerialization.jsonObject(with: data)
                            success(jsonValue)
                        } catch {
                            
                            print("Response of \(url):\n \(String(data: data, encoding: .utf8) ?? "")")
                            print(error.localizedDescription)
                            print(error)
                            failure(error.localizedDescription)
                        }
                    case .failure(let error):
                        print("Response of \(url):\n \(error.localizedDescription)")
                        print(error.localizedDescription)
                        print(error)
                        failure(error.localizedDescription)
                    }
                }
            }
        }
        else {
            connectionFailed("No internet connection availabel")
        }
    }

}
