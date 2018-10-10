//
//  LogInViewC.swift
//  TravelFlix
//
//  Created by Ramneet Singh on 19/07/18.
//  Copyright © 2018 Ramneet Singh. All rights reserved.
//

import UIKit
import SWRevealViewController
import FBSDKLoginKit
import FBSDKCoreKit
//import TwitterKit
//import TwitterCore

class LogInViewC: UIViewController, PopUpCustom {
    
    func sendAction(textField: String) {
        
        forgotPAssword(email: textField)
    }
    

    @IBOutlet weak var txtF_Email: UITextField!
    
     @IBOutlet weak var txtF_Password: UITextField!
    
    var checked : Bool = false
    var userDetail : [String: Any] = [:]
    
    
    //    var useD: [UserDetailModel] = UserDetailModel.callService(str: "d", methd: "df"){
    //        didSet{
    //
    //              }
    //            willSet(newV){
    //            if newV.city != "" {
    //                useD.city = newV.city
    //            }
    //        }
    //    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.keepMeIn = false
        
               let ap = AppDelegate.getAppdelegate()
                ap.customNevigationBar(isHidden: true, statusBarColor: UIColor.clear, styleLightDefaultDark: .default)
        
        UIApplication.shared.statusBarStyle = .default
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func keepMeSignIn(_ sender: UIButton) {
        
        if sender.currentBackgroundImage == #imageLiteral(resourceName: "ic_checkbox_selected"){
            sender.setBackgroundImage( #imageLiteral(resourceName: "ic_checkbox_unselected"), for: .normal)
            DataManager.keepMeIn = false
            checked = false
        }else{
            sender.setBackgroundImage(#imageLiteral(resourceName: "ic_checkbox_selected"), for: .normal)
            DataManager.keepMeIn = true
            checked = true
        }
        
    }
    //MARK: Buttons
   
    @IBAction func logInWithFB(_ sender: UIButton) {
        loginWithFB()
    }
    
    @IBAction func logInWithTwitter(_ sender: UIButton) {
        
//        Twitter.sharedInstance().logIn(completion: { (session, error) in
//            if (session != nil) {
//                print("signed in as \(String(describing: session?.userName))");
//            } else {
//                print("error: \(String(describing: error?.localizedDescription))");
//            }
//        })

    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        
        login()
    }
    
    
    
    @IBAction func forgotPassword(_ sender: UIButton) {
        
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopUpBaseClass") as! PopUpBaseClass
        popOverVC.delegate = self
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    
    @IBAction func createNewAccount(_ sender: UIButton) {
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewC") as! SignUpViewC
        
        self.navigationController?.pushViewController(next, animated: true)
        
    }
    
    func login(){
        
        if (!txtF_Email.hasText){
            
            alertResponseWithTextField(message: "Please enter Email" , textField: txtF_Email)
            return
            
        }else if (!Validations.checkEmailValid(txtF_Email)){
            alertResponseWithTextField(message: "Please enter valid Email", textField: txtF_Email)
            return
        }
            
        else if (!txtF_Password.hasText){
            alertResponseWithTextField(message: "Please enter Password", textField: txtF_Password)
            return
            
        }else if (!Validations.checkStrongPassword(txtF_Password)){
            alertResponseWithTextField(message: "Password should be greater than six characters", textField: txtF_Password)
            return
        }
        
        
        let params = ["email": txtF_Email.text!.lowercased(),
                      "password": txtF_Password.text!,
                      "deviceToken": "123",
                      "deviceType":"ios"] as [String : Any]
        
     
        view.addSubview(GetLoader.ShowLoader)
        
        ViewModel.sharedVM.logIn(function: ServicesName.logIn, params: params, headers: [:], success: { (bool, ResponseDic, city) in
            GetLoader.ShowLoader.removeFromSuperview()
            
            if bool {
                if let data = ResponseDic["data"] as? NSDictionary{
                   
                  let otp_verify = data.value(forKey: "otp_verify") as? String
                    if otp_verify == "1"{
                    
                            let first_Time = data.value(forKey: "first_time") as? String
                            DataManager.userId = Int((data.value(forKey: "id") as? String)!)
                            DataManager.user_name = data.value(forKey: "name") as? String
                    
                            if first_Time == "1"{
                        
                                    let next = self.storyboard?.instantiateViewController(withIdentifier: "HostCategoryViewC") as! HostCategoryViewC
                                    self.navigationController?.pushViewController(next, animated: true)
                        
                                }else{
                                    let next = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                                    self.navigationController?.pushViewController(next, animated: true)
                                   }
                        
                    }else if otp_verify == "0"{
                        
                        DataManager.userId = Int((data.value(forKey: "id") as? String)!)
                        DataManager.user_name = data.value(forKey: "name") as? String
                        
                        let next = self.storyboard?.instantiateViewController(withIdentifier: "VerificationVc") as! VerificationVc
                        
                        self.navigationController?.pushViewController(next, animated: true)
                    }
                    
                }
                
               
            }else{
                self.alertResponse(message: ResponseDic["mesg"] as! String)
            }
            
        }) { (bool, array) in
            
            GetLoader.ShowLoader.removeFromSuperview()
            self.alertResponse(message: array[1])
        }
    }
    
    
    
    
    func forgotPAssword(email: String){
        
        if email == ""{
            alertResponseWithTextField(message: "Please enter email", textField: txtF_Password)
            return
        }
        
        let params = ["email": email,
                      "userType": "1"] as [String : Any]
        
        
        view.addSubview(GetLoader.ShowLoader)
        ViewModel.sharedVM.forgotPassword(function: ServicesName.forgotPassword, params: params, headers:  [:], success: { (value, dic) in
            GetLoader.ShowLoader.removeFromSuperview()
            if value {
                
                self.alertResponse(message: dic["mesg"] as! String)
            }else{
                self.alertResponse(message: dic["mesg"] as! String)
            }
            
        }) { (value, array) in
            
            GetLoader.ShowLoader.removeFromSuperview()
            self.alertResponse(message: array[1])
            
        }
        

        
        
    }
    
    
    
}


extension LogInViewC {
    
    //MARK:- custom functions
    func loginWithFB(){
        let loginManager : FBSDKLoginManager = FBSDKLoginManager.init()
        
        loginManager.logIn(withReadPermissions: ["public_profile","email","user_birthday"], from: self) { (result, Error) in
            
            if Error == nil
            {
                
                FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields":"email,first_name,gender,last_name,birthday,about"]).start(completionHandler: { (FBSDKGraphRequestConnection, result1, Error) in
                    if result1 != nil
                    {
                        
                        
                        let json = result1 as! NSDictionary
                        let strDate : String  = (json.object(forKey: "birthday") as! String!)!
                        if strDate != ""
                        {
                            let dateFormatter : DateFormatter = DateFormatter.init()
                            dateFormatter.dateFormat = "dd/MM/yyyy"
                            
                        }
                        
                        
                        let fbAccessToken = FBSDKAccessToken.current().tokenString
                        
                        let firstName = json.object(forKey: "first_name") as? String
                        let lastName = json.object(forKey: "last_name") as? String
                        
                    
                        
                        print(firstName!)
                        
                        self.userDetail =  ["name": firstName! + " " + lastName! as Any,
                                               "email":(json.object(forKey: "email") as?String) as Any,
                                               "facebook_uid":fbAccessToken as Any]
                        
                        
                        
                        if self.userDetail["name"] != nil{
                            let storyboar = UIStoryboard(name: "Main", bundle: nil)
                            
                            let secondViewController = storyboar.instantiateViewController(withIdentifier: "SignUpViewC") as! SignUpViewC
                            
                            secondViewController.userDetail = self.userDetail
                            secondViewController.signInWithFB = true
                            self.navigationController?.pushViewController(secondViewController, animated: true)
                            
                        }
                        
                    }
                })
            }
            else
            {
                
            }
        }
        
    }
    
    
}
