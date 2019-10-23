//
//  NSMutableAttributedString + Combination.swift
//  MovieDiary
//
//  Created by Raul on 23/10/2019.
//  Copyright © 2019 Raul. All rights reserved.
//

import Foundation

extension NSMutableAttributedString {
    static func + (left: NSMutableAttributedString, right: NSAttributedString) -> NSMutableAttributedString {
        let result = NSMutableAttributedString()
        result.append(left)
        result.append(right)
        return result
    }
}
