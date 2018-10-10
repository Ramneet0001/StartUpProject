//
//  Network.swift
//  TravelFlix
//
//  Created by Ramneet Singh on 20/07/18.
//  Copyright © 2018 Ramneet Singh. All rights reserved.
//

import UIKit

import Foundation
import Alamofire
import SystemConfiguration

typealias TAServiceSuccessCallbackJson = (([String:Any]) -> ())
typealias TAServiceSuccessCallback = ((Data?) -> ())
typealias TAServiceSuccessTrueFalseCallBack = ((Bool , String) -> ())
typealias TAServiceSuccessTrueCallBack = ((Bool , TAServiceSuccessCallback) -> ())
typealias TAServiceFailureCallback = ((NetworkErrorReason?, NSError?) -> ())
typealias TAServiceFailureBack = ((NSError?,[String]) -> ())
typealias TAServiceSuccessBoolCallbackJson = (([String:Any], Bool) -> ())
typealias TAServiceSuccessBoolCallbackJsonAnyObj = (([String:AnyObject], Bool) -> ())


// MARK:- NetworkErrorReason
public enum NetworkErrorReason: Error {
    
    case FailureErrorCode(code: Int, message: String)
    case InternetNotReachable
    case UnAuthorizedAccess
    case Other
}

// MARK:- Resource
struct Resource {
    
    let method: HTTPMethod
    let parameters: [String : Any]?
    let headers: [String:String]?
}




//MARK: API Manager Class
class APIManager {
    
    public static let sharedAPI = APIManager()
    private init() {}
    
    
    //MARK:- Custom Get methods for Url
    func requestResponceStatus(url: String, isURLEncoded: Bool = false,method: HTTPMethod, parameters: [String : Any]?, headers: HTTPHeaders ,  success: @escaping TAServiceSuccessBoolCallbackJson, failure: @escaping TAServiceFailureBack){
        do {
            
            let formattedString = url.replacingOccurrences(of: " ", with: "")
            
            var encoding: URLEncoding = .default
            if method == .get || method == .head || method == .delete || isURLEncoded{
                encoding = .queryString
            }
            
            print(" formattedString = ",formattedString)
            print(" method = ",encoding)
            print(" headers = ",headers)
            print(" parameters = ",parameters as Any)
            
            Alamofire.request(formattedString, method: .post , parameters: parameters, encoding: encoding, headers: headers).responseJSON(completionHandler: { (responce) in
               // print(responce.response?.statusCode)
                
                if (responce.error != nil)
                {
                    failure(responce.error as NSError?, self.errorForNetworkErrorReason(checkReason: responce.error as NSError? ))
                }
                
                if (responce.data != nil)
                {
                    do {
                        if let json = try? JSONSerialization.jsonObject(with: responce.data!, options: .allowFragments) as! [String: Any]{
                            
                            if responce.response?.statusCode == 200 {
                                success(json, true)
                            }else if responce.response?.statusCode == 404 {
                                success(json, false)
                            }
                          }
                        }
                    
                }
            })
            
        }
    }
    
    
   
    
    //MARK:- Custom Get methods for Url
    func requestResponceStatus2(url: String, isURLEncoded: Bool = false,method: HTTPMethod, parameters: [String : Any]?, headers: HTTPHeaders ,  success: @escaping TAServiceSuccessBoolCallbackJsonAnyObj, failure: @escaping TAServiceFailureBack){
        do {
            
            let formattedString = url.replacingOccurrences(of: " ", with: "")
            
            var encoding: URLEncoding = .default
            if method == .get || method == .head || method == .delete || isURLEncoded{
                encoding = .queryString
            }
            
            print(" formattedString = ",formattedString)
            print(" method = ",encoding)
            print(" headers = ",headers)
            print(" parameters = ",parameters as Any)
            
            Alamofire.request(formattedString, method: .post , parameters: parameters, encoding: encoding, headers: headers).responseJSON(completionHandler: { (responce) in
                // print(responce.response?.statusCode)
                
                if (responce.error != nil)
                {
                    failure(responce.error as NSError?, self.errorForNetworkErrorReason(checkReason: responce.error as NSError? ))
                }
                
                if (responce.data != nil)
                {
                    do {
                        if let json = try? JSONSerialization.jsonObject(with: responce.data!, options: .allowFragments) as! [String: Any]{
                            
                            if responce.response?.statusCode == 200 {
                                success(json as [String : AnyObject], true)
                            }else if responce.response?.statusCode == 404 {
                                success(json as [String : AnyObject], false)
                            }
                        }
                    }
                    
                }
            })
            
        }
    }
    
    
    
    
    
    //MARK:- Custom Get methods for Url
    func request(url: String, isURLEncoded: Bool = false,method: HTTPMethod, parameters: [String : Any]?, headers: HTTPHeaders ,  success: @escaping TAServiceSuccessCallbackJson, failure: @escaping TAServiceFailureBack){
        do {
            
            let formattedString = url.replacingOccurrences(of: " ", with: "")
            
            var encoding: URLEncoding = .default
            if method == .get || method == .head || method == .delete || isURLEncoded{
                encoding = .queryString
            }
            
            print(" formattedString = ",formattedString)
            print(" method = ",encoding)
            print(" headers = ",headers)
            print(" parameters = ",parameters as Any)
            
            Alamofire.request(formattedString, method: .post , parameters: parameters, encoding: encoding, headers: headers).responseJSON(completionHandler: { (responce) in
                 print(responce.response?.statusCode)
                
                
                if (responce.error != nil)
                {
                 failure(responce.error as NSError?, self.errorForNetworkErrorReason(checkReason: responce.error as NSError?))
                }
                
                if (responce.data != nil)
                {
                    do {
                        if let json = try? JSONSerialization.jsonObject(with: responce.data!, options: .allowFragments) as! [String: Any]{
                            
                            print("json",json)
                            success(json)
                        }
                    }
                    
                }
            })
            
        }
    }
    
    
    
    
    
    func requestWithImageData(url: String, parameters: [String : Any]?, headers: HTTPHeaders ,  imageData:[String: UIImage], onCompletion: @escaping TAServiceSuccessCallbackJson , onError: @escaping TAServiceFailureBack) {
        
        //        let headersAre: HTTPHeaders = ["authToken":"fbc84b26c49d20045ee9cadcf00f7b01",
        //            "Content-type": "application/x-www-form-urlencoded",
        //            "Client-Service":"miranoo_client",
        //            "Auth-Key":"miranoo_api"]
        //
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            for (key , value) in imageData{  // used for images
                
                multipartFormData.append(UIImageJPEGRepresentation(value , 0.5)!, withName: key, fileName: "image.jpeg", mimeType: "image/jpeg")
            }
            
            for (key, value) in parameters! { // Used for params
                
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
            
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers) { (result) in
            
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("Succesfully uploaded")
                    
                    
                    do {
                        if let json = try? JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as! [String: Any]{
                            
                            onCompletion(json)
                        }
                    }
                }
                
                
                
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                
                
            }
            
        }
    }
    
    
   
    func requestWithMultiImagesData(url: String, parameters: [String : Any]?, headers: HTTPHeaders ,  imageData:[String: UIImage], onCompletion: @escaping TAServiceSuccessTrueFalseCallBack , onError: @escaping TAServiceFailureBack) {
        
        //        let headersAre: HTTPHeaders = ["authToken":"fbc84b26c49d20045ee9cadcf00f7b01",
        //            "Content-type": "application/x-www-form-urlencoded",
        //            "Client-Service":"miranoo_client",
        //            "Auth-Key":"miranoo_api"]
        //
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            for (key , value) in imageData{  // used for images
                
                let timestamp = NSDate().timeIntervalSince1970
                multipartFormData.append(UIImageJPEGRepresentation(value , 0.5)!, withName: key, fileName: "_\(DataManager.userId!)_image_\(timestamp)_.jpeg", mimeType: "image/jpeg")
            }
            
            for (key, value) in parameters! { // Used for params
                
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
            
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers) { (result) in
            
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("Succesfully uploaded")
                    
                     onCompletion( true , "")
                }
                
                
                
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                
                  onCompletion( false , "")
            }
            
        }
    }
    
    
    
    
    
    func isConnectedToNetwork() -> Bool {
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
        if flags.isEmpty {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    
    
    func errorForNetworkErrorReason(checkReason: NSError?) -> [String]{
        
        if isConnectedToNetwork() == false {
            
            return ["No Internet", "The Internet connection appears to be offline"]
            
        } else if checkReason?.code == 500 {
            
            return ["Authorization Failed", "Please Re-login to the app"]
            
        }
        
        return ["Alert", "Something went wrong"]
    }
    
    
    
    
    
    
    
    
    
    
}



//MARK: Indicator Class
public class Indicator {
    
    public static let sharedInstance = Indicator()
    
    var indicatorNV = UIActivityIndicatorView()
    
    var blurImg = UIImageView()
    var indicator = UIActivityIndicatorView()
    static var isEnabledIndicator = true
    
    private init() {
        
        blurImg.frame = UIScreen.main.bounds
        blurImg.backgroundColor = UIColor.black
        blurImg.isUserInteractionEnabled = true
        blurImg.alpha = 0.5
        indicator.activityIndicatorViewStyle = .whiteLarge
        indicator.center = blurImg.center
        indicator.startAnimating()
        indicator.color = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        
    }
    
    func showIndicator(){
        
        DispatchQueue.main.async( execute: {
            
            UIApplication.shared.keyWindow?.addSubview(self.blurImg)
            //UIApplication.shared.keyWindow?.addSubview(self.indicator)
        })
    }
    func hideIndicator(){
        
        DispatchQueue.main.async( execute: {
            
            self.blurImg.removeFromSuperview()
            // self.indicator.removeFromSuperview()
        })
    }
    
    
}

