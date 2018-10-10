//
//  Validations.swift
//  EatDigger
//
//  Created by Ramneet Singh on 02/05/18.
//  Copyright © 2018 Ramneet Singh. All rights reserved.
//

import Foundation
import UIKit

var validationSingletonObject: Validations? = nil

class Validations: NSObject
{
    class func someTypeMethod()-> Validations {
        //body
        if validationSingletonObject == nil {
            validationSingletonObject = Validations()
        }
        
        return validationSingletonObject!
    }
    
    class func IsTextPresent(_ textField: UITextField) -> Bool
    {
        if (textField.text == "") {
            //textField.layer.borderColor = UIColor.redColor().CGColor
            return false
        }
        else {
            return true
        }
    }
    
    class func IsTextViewPresent(_ textField: UITextView) -> Bool
    {
        if (textField.text == "") {
            //textField.layer.borderColor = UIColor.redColor().CGColor
            return false
        }
        else {
            return true
        }
    }
    
    class func IsTextPresentTextField(_ textField: UITextField) -> Bool
    {
        if (textField.text == "") {
            //textField.layer.borderColor = UIColor.redColor().CGColor
            return false
        }
        else {
            return true
        }
    }
    
    class func IsBtnTextField(_ btn: UIButton) -> Bool
    {
        if (btn.currentTitle == "") {
            //textField.layer.borderColor = UIColor.redColor().CGColor
            return false
        }
        else {
            return true
        }
    }
    
    class func checkStrongPassword(_ textField: UITextField) -> Bool {
        if (textField.text?.characters.count)! < 6 {
            
            return false
        }
        else {
            return true
        }
    }
    
    class func checkMinimumRequiredField(_ textField: UITextField) -> Bool {
        if (textField.text?.characters.count)! < 3 {
            
            return false
        }
        else {
            return true
        }
    }
    
    class func checkValidMobileNumber(_ textField: UITextField) -> Bool {
        if (textField.text?.characters.count)! < 10 {
            
            return false
        }
        else {
            return true
        }
    }
    
    class func doesPasswordMatched(_ password: UITextField, ConfirmPassword pasword2: UITextField) -> Bool {
        if !(password.text == pasword2.text) {
            //pasword2.layer.borderColor = UIColor.redColor().CGColor
            return false
        }
        else {
            return true
        }
    }
    
    class func checkEmailValid(_ email: UITextField) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        if emailTest.evaluate(with: email.text) {
            return true
        }
        else {
            return false
        }
    }
    
    
    class func validateNumber(value: String) -> Bool {
        let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,14}$";    let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    
}


extension String {
    
    public func isPhone()->Bool {
        if self.isAllDigits() == true {
            let phoneRegex = "[235689][0-9]{6}([0-9]{3})?"
            let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return  predicate.evaluate(with: self)
        }else {
            return false
        }
    }
    
    private func isAllDigits()->Bool {
        let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
        let inputString = self.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return  self == filtered
    }
}


