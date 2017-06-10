//
//  UIColor+Extensions.swift
//  Swipeless
//
//  Created by Silver Logic on 6/10/17.
//  Copyright © 2017 Silver Logic. All rights reserved.
//

import UIKit

fileprivate extension UIColor {
    /**
     Gets the color from a given hexidecimal value.
     
     - Parameter hexValue: An `UInt` representing the hexidecimal value
     
     - Returns: An `UIColor` object containing the color generated from `hexValue`.
     */
    fileprivate static func colorFromHexValue(_ hexValue: UInt) -> UIColor {
        let redValue = ((Float)((hexValue & 0xFF0000) >> 16)) / 255.0
        let greenValue = ((Float)((hexValue & 0xFF00) >> 8)) / 255.0
        let blueValue = ((Float)(hexValue & 0xFF)) / 255.0
        return UIColor(colorLiteralRed: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
    }
}

extension UIColor {
    // Main color
    static var pink: UIColor { return colorFromHexValue(pinkHexValue) }
}


extension UIColor {
    @nonobjc static var pinkHexValue: UInt = 0xFF6281
}
