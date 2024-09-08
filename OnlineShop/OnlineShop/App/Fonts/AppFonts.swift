//
//  AppFonts.swift
//  OnlineShop
//
//  Created by Анастасия Ларина on 09.05.2024.
//

import UIKit

enum AppFonts {
    case regular10
    case regular12
    case regular13
    case bold14
    case medium12
    case medium14

    var font: UIFont? {
        switch self {
        case .regular10:
            return UIFont(name: "Inter-Regular", size: 13)
        case .regular12:
            return UIFont(name: "Inter-Regular", size: 16)
        case .regular13:
            return UIFont(name: "Inter-Regular", size: 18)
        case .bold14:
            return UIFont(name: "Inter-Bold", size: 14)
        case .medium12:
            return UIFont(name: "Inter-Medium", size: 12)
        case .medium14:
            return UIFont(name: "Inter-Medium", size: 14)
        }
    }
}

enum AppColors {
    static let green = UIColor().hex(0x67C4A7)
}

extension UIColor {
    func hex(_ rgbValue: UInt64) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
