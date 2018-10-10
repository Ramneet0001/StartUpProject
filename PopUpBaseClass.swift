//
//  PopUpBaseClass.swift
//  TravelFlix
//
//  Created by Ramneet Singh on 20/07/18.
//  Copyright © 2018 Ramneet Singh. All rights reserved.
//

import UIKit

protocol PopUpCustom {
    
    func sendAction(textField: String)
    
    
}

class PopUpBaseClass: UIViewController{
    
  
    @IBOutlet weak var txtF_email: UITextField!
    
    var delegate : PopUpCustom? = nil
    
    @IBOutlet weak var lbl_validations: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbl_validations.isHidden = true
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        self.showAnimate()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func closeAction(_ sender: UIButton) {
         self.removeAnimate()
    }
    
    
    @IBAction func sendEmail(_ sender: UIButton) {
        
        
        if (!txtF_email.hasText){
            
            lbl_validations.isHidden = false
            lbl_validations.text = "Please enter Email"
            return
            
        }else if (!Validations.checkEmailValid(txtF_email)){
            lbl_validations.isHidden = false
            lbl_validations.text = "Please enter valid Email"
            return
        }
        
        
           self.removeAnimate()
        delegate?.sendAction(textField: txtF_email.text!)
    }
 
//
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.35, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.35, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    
    
  
    
}




extension PopUpBaseClass : UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
         lbl_validations.isHidden = true
            }
            
            
        }

    
    



