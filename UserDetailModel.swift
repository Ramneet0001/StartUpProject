//
//  UserDetailModel.swift
//  TravelFlix
//
//  Created by Ramneet Singh on 24/07/18.
//  Copyright © 2018 Ramneet Singh. All rights reserved.
//

import Foundation

class UserDetailModel {

   
    var id = String()
    var name = String()
    var email = String()
    var deviceType = String()
   
    var deviceToken = String()
    var userType = String()
    var image = String()
    var phone = String()
    
    var social_id = String()
    var first_time = String()
    var city = String()
    var state = String()
    
    var country = String()
    var city_name = String()
    var state_name = String()
    var country_name = String()
    
    var otp = String()
    var otp_verify = String()
  
    
    init(Dic: [String: AnyObject]) {
        
        id            = Dic["id"] as! String
        name          = Dic["name"] as! String
        email         = Dic["email"] as! String
        deviceType    = Dic["deviceType"] as! String
        
        deviceToken   = Dic["deviceToken"] as! String
        userType      = Dic["userType"] as! String
        image         = Dic["image"] as! String
        phone         = Dic["phone"] as! String
        
        social_id        = Dic["social_id"] as! String
        first_time       = Dic["first_time"] as! String
        city             = Dic["city"] as! String
        state            = Dic["state"] as! String
        
        country          = Dic["country"] as! String
        city_name        = Dic["city_name"] as! String
        state_name      = Dic["state_name"] as! String
        country_name    = Dic["country_name"] as! String
        
        otp             = Dic["otp"] as! String
        otp_verify      = Dic["otp_verify"] as! String
        
        DataManager.userId = Int(Dic["id"] as! String)
        
    }
    
//    class func callService(str: String, methd:String){
//        
//        
//    }
    
}
