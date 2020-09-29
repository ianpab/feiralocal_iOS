//
//  UIView+Extension.swift
//  FeiraLocal
//
//  Created by Ian Pablo on 27/09/20.
//  Copyright © 2020 Ian Pablo. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
   
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
