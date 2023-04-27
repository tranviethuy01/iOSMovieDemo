//
//  UIFont.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//  Copyright © 2023 Tran Viet Huy. All rights reserved.

import Foundation
import UIKit
enum DefaultFontType: String {
    case light = "Light"
    case lightIt = "LightIt"
    case semibold = "Semibold"
    case semiboldIt = "SemiboldIt"
    case it = "It"
    case bold = "Bold"
    case regular = "Regular"
    case boldIt = "BoldIt"
    case black = "Black"
    case blackIt = "BlackIt"
    case extraLight = "ExtraLight"
    case extraLightIt = "ExtraLightIt"
    case semiBold = "SemiBold"
}
extension UIFont {
    /**
      Init with custom font for this app
    */
    convenience init?(defaultFontType: DefaultFontType, size: CGFloat) {
        self.init(name: "SourceSansPro-" + defaultFontType.rawValue, size: size)
    }
}

