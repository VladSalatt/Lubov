//
//  UIColor+Ext.swift
//  lubov
//
//  Created by VKoshelev@detmir.ru on 19.06.2022.
//

import UIKit

extension UIColor {
    static let darkGreenColor = UIColor(hex: 0x5FD068)
    static let lightGreenColor = UIColor(hex: 0xC2DED1)
    static let sandColor = UIColor(hex: 0xECE5C7)
    static let landColor = UIColor(hex: 0xCDC2AE)
    static let darkBlueColor = UIColor(hex: 0x354259)
    
    convenience init(hex: Int, alpha: CGFloat = 1) {
        let red = (hex >> 16) & 0xFF
        let green = (hex >> 8) & 0xFF
        let blue = hex & 0xFF

        self.init(
            red: .init(red) / 255,
            green: .init(green) / 255,
            blue: .init(blue) / 255,
            alpha: alpha
        )
    }
}
