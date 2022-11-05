//
//  UIColor+hexaString.swift
//  Pokemon App
//
//  Created by Nadia Darin on 05/11/22.
//

import UIKit

extension UIColor {
    convenience init(hexaString: String, alpha: CGFloat = 1) {
        self.init(hexa: UInt(hexaString.dropFirst(), radix: 16) ?? 0, alpha: alpha)
    }
    convenience init(hexa: UInt, alpha: CGFloat = 1) {
        self.init(red:   .init((hexa & 0xff0000) >> 16) / 255,
                  green: .init((hexa & 0xff00  ) >>  8) / 255,
                  blue:  .init( hexa & 0xff    )        / 255,
                  alpha: alpha)
    }
}
