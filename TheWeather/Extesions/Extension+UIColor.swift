//
//  Extension+UIColor.swift
//  TheWeather
//
//  Created by Иван Луганцов on 24.05.2023.
//

import UIKit

extension UIColor {
    
    class var brandLightGray: UIColor {
       UIColor(hexString: "#EFEFF4")
    }
    
    class var brandOrange: UIColor {
        UIColor(hexString: "#FF8A05")
    }
    
    class var brandTintColorGray: UIColor {
        UIColor(hexString: "#555969")
    }
    
    convenience init(hexString: String, alpha: Double = 1.0) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)

        let red, green, blue: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (red, green, blue) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (red, green, blue) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (red, green, blue) = (1, 1, 0)
        }
        self.init(red: CGFloat(red) / 255.0,
                  green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0,
                  alpha: CGFloat(255.0 * alpha) / 255.0)
    }
}

