//
//  DataManager.swift
//  EatDigger
//
//  Created by Ramneet Singh on 02/05/18.
//  Copyright © 2018 Ramneet Singh. All rights reserved.
//

import Foundation

class DataManager: NSObject {
    
    
    static var device_token:String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "device_token")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: "device_token")
        }
    }
    
    
    static var user_name:String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "user_name")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: "user_name")
        }
    }
    
    
    static var userId:Int? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "userId")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.integer(forKey: "userId")
        }
    }
    
    
    
    static var currentLati: Double? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "currentLati")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.double(forKey: "currentLati")
        }
    }
  
    
    static var rating:Int? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "rating")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.integer(forKey: "rating")
        }
}
    
    static var keepMeIn:Bool? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "keepMeIn")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.bool(forKey: "keepMeIn")
        }
    }

}
