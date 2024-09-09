//
//  ColorSets.swift
//  BAT_iOS_testing
//
//  Created by Dawei Hao on 2024/9/9.
//

import UIKit

struct Colors {
    
    static let white    = UIColor.white
    static let darkGray = UIColor.darkGray
    static let clear    = UIColor.clear
    
    static func hexStringToUIColor(hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if cString.count != 6 {
            return UIColor.gray
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: 1.0
        )
    }
}

struct Images {
    static let list: UIImage    = UIImage(named: "icon_list")!
    static let youbike: UIImage = UIImage(named: "Youbike")!
    static let cancel: UIImage  = UIImage(systemName: "xmark")!
}
