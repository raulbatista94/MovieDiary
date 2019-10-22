//
//  UIColor+RGB.swift
//  MovieDiary
//
//  Created by Raul on 20/10/2019.
//  Copyright © 2019 Raul. All rights reserved.
//

import UIKit

extension UIColor {
    func fromRGB(rgb: UInt, alpha: Double) -> UIColor {
        return UIColor(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
}
