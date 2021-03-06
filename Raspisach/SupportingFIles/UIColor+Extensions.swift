//
//  UIColor+Extensions.swift
//  Tchannels
//
//  Created by Константин on 07.11.2017.
//  Copyright © 2017 Константин. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let mainButtonColor = UIColor(hex: "D23E47")
    

    
    convenience public init(hex: String) {
        let color: UIColor = {
            var cString:String = hex.trimmingCharacters(in: (NSCharacterSet.whitespacesAndNewlines as NSCharacterSet) as CharacterSet).uppercased()
            
            if (cString.hasPrefix("#")) {
                cString.remove(at: cString.startIndex)
            }
            
            if ((cString.count) != 6) {
                return UIColor.gray
            }
            
            var rgbValue:UInt32 = 0
            Scanner(string: cString).scanHexInt32(&rgbValue)
            
            return UIColor(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
            )
        }()
        
        self.init(cgColor: color.cgColor)
    }
}



