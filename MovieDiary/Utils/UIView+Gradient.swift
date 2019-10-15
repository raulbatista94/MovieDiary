//
//  UIView+Gradient.swift
//  MovieDiary
//
//  Created by Raul on 15/10/2019.
//  Copyright © 2019 Raul. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func setGradientBackground(color1: UIColor, color2: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [color1, color2]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
