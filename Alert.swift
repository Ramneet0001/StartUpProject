//
//  Alert.swift
//  TravelFlix
//
//  Created by Ramneet Singh on 26/07/18.
//  Copyright © 2018 Ramneet Singh. All rights reserved.
//

import Foundation
import UIKit


class Alert: NSObject {
    
    typealias CompletionHandler = (() -> Swift.Void)?
    typealias CompletionHandlerResponce = ((Bool) -> ())
    
    func showTimerAlert(withTitle title: String, withMessage message: String, inView view: UIViewController, completionHandler: CompletionHandler){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        view.present(alertController, animated: true, completion: {})
        
        let when = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: when){
            alertController.dismiss(animated: true, completion:
                {
                    
                    completionHandler?()
                    
            })
        }
    }
    
    
    func showTimerAlertAndAction(withTitle title: String, withMessage message: String, inView view: UIViewController, completionHandlerResponce: @escaping CompletionHandlerResponce){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        view.present(alertController, animated: true, completion: {})
        
        let when = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: when){
            alertController.dismiss(animated: true, completion:
                {
                    completionHandlerResponce(true)
            })
        }
    }
    
    func showAlertAndAction(withTitle title: String, withMessage message: String, inView view: UIViewController, completionHandlerResponce: @escaping CompletionHandlerResponce){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        view.present(alertController, animated: true, completion: {})
        
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when){
            alertController.dismiss(animated: true, completion:
                {
                    completionHandlerResponce(true)
            })
        }
    }
    
    
    func showAlertAndChooseAction(withTitle title: String, withMessage message: String, inView view: UIViewController, completionHandlerResponce: @escaping CompletionHandlerResponce){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        let okAction =  UIAlertAction(title: "Ok", style: .default) { (alertAction) in
             completionHandlerResponce(true)
//
//                alertController.dismiss(animated: true, completion:
//                    {
//                        completionHandlerResponce(true)
//                })
        }
        let cancelAction =  UIAlertAction(title: "Cancel", style: .cancel) { (alertAction) in
            completionHandlerResponce(false)
//            alertController.dismiss(animated: true, completion:
//                {
//                    completionHandlerResponce(false)
//            })
        }
        
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        view.present(alertController, animated: true, completion: {})
        
    }
    
}
