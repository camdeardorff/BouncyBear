//
//  extension-UIColor.swift
//  BouncyBear
//
//  Created by Cameron Deardorff on 5/19/18.
//  Copyright © 2018 Cameron Deardorff. All rights reserved.
//

import UIKit
import SpriteKit

extension UIColor {
 
    static let pastels: [UIColor] = [pastelLightBlue, pastelBlue, pastelGreen, pastelLightGreen, pastelYellow, pastelOrange, pastelPink, pastelPurple].reversed()
    
    static let pastelLightBlue = UIColor(red: 0.537, green: 0.765, blue: 0.831, alpha: 1.00)
    static let pastelBlue = UIColor(red: 0.357, green: 0.600, blue: 0.651, alpha: 1.00)
    static let pastelGreen = UIColor(red: 0.541, green: 0.749, blue: 0.443, alpha: 1.00)
    static let pastelLightGreen = UIColor(red: 0.788, green: 0.831, blue: 0.373, alpha: 1.00)
    static let pastelYellow = UIColor(red: 0.945, green: 0.839, blue: 0.361, alpha: 1.00)
    static let pastelOrange = UIColor(red: 0.898, green: 0.565, blue: 0.282, alpha: 1.00)
    static let pastelPink = UIColor(red: 0.851, green: 0.443, blue: 0.627, alpha: 1.00)
    static let pastelPurple = UIColor(red: 0.702, green: 0.408, blue: 0.639, alpha: 1.00)
}


extension UIColor {
    func darker() -> UIColor {
        
        var r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0, a:CGFloat = 0
        if self.getRed(&r, green: &g, blue: &b, alpha: &a){
            return UIColor(red: max(r - 0.2, 0.0), green: max(g - 0.2, 0.0), blue: max(b - 0.2, 0.0), alpha: a)
        } else {
            return UIColor()
        }
    }
    
    func lighter() -> UIColor {
        
        var r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0, a:CGFloat = 0
        if self.getRed(&r, green: &g, blue: &b, alpha: &a){
            return UIColor(red: min(r + 0.2, 1.0), green: min(g + 0.2, 1.0), blue: min(b + 0.2, 1.0), alpha: a)
        } else {
            return UIColor()
        }
    }
}

extension UIColor {
    var skColor: SKColor {
        return SKColor(cgColor: self.cgColor)
    }
    
    var coreImageColor: CIColor {
        return CIColor(color: self)
    }
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let color = coreImageColor
        return (color.red, color.green, color.blue, color.alpha)
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
