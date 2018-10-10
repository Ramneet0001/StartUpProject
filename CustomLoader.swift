//
//  CustomLoader.swift
//  TravelFlix
//
//  Created by Ramneet Singh on 20/07/18.
//  Copyright © 2018 Ramneet Singh. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class GetLoader: CustomLoader {
    static let ShowLoader = CustomLoader()
}


class CustomLoader : UIView {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        backgroundColor = #colorLiteral(red: 0.8404980964, green: 0.8404980964, blue: 0.8404980964, alpha: 0.6286386986)
        let animationView = LOTAnimationView(name: "animation-w800-h600-2")
        animationView.frame = CGRect(x: 0, y: 0, width: 130, height: 130)
        animationView.center = center
        animationView.contentMode = .scaleAspectFill
        
        addSubview(animationView)
        animationView.loopAnimation = true
        
        animationView.play()
        
        
        
    }
    func Show()  {
        isHidden = false
    }
    func Hide()  {
        isHidden = true
    }
    
    static func openDialingScreen(parent:UIViewController){
    }
    
}
