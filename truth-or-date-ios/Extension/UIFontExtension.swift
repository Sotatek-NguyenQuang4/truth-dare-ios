//
//  UIFontExtension.swift
//  Earable
//
//  Created by Admin on 23/03/2022.
//  Copyright © 2022 Earable. All rights reserved.
//

import UIKit

extension UIFont {
    static let exampleText = "😉ABCDEFGHIJKLMNOPQRSTUVWXYZ"
}

extension UIFont {
    static func regular(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    static func light(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .light)
    }
    
    static func bold(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .bold)
    }
    
    static func semibold(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .semibold)
    }
    
    static func medium(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .medium)
    }
    
    var italic: UIFont {
        return self.with(traits: .traitItalic)
    }
    
    func with(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(traits) else {
            return self
        }
        return UIFont(descriptor: descriptor, size: self.pointSize)
    }
}

extension UIFont {
    
    /// Avenir Font weight:  700
    /// - Parameter size: font size
    /// - Returns: Avenir font
    static func avenirHeavy(_ size: CGFloat) -> UIFont {
        guard let avenirFont = UIFont(name: "Avenir-Heavy", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: .heavy)
        }
        return avenirFont
    }
    
    /// Avenir Font weight:  900
    /// - Parameter size: font size
    /// - Returns: Avenir font
    static func avenirBlack(_ size: CGFloat) -> UIFont {
        guard let avenirFont = UIFont(name: "Avenir-Black", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: .black)
        }
        return avenirFont
    }
    
    /// Avenir Font weight:  300
    /// - Parameter size: font size
    /// - Returns: Avenir font
    static func avenirBook(_ size: CGFloat) -> UIFont {
        guard let avenirFont = UIFont(name: "Avenir-Book", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: .light)
        }
        return avenirFont
    }
    
    /// Avenir Font weight:  500
    /// - Parameter size: font size
    /// - Returns: Avenir font
    static func avenirMedium(_ size: CGFloat) -> UIFont {
        guard let avenirFont = UIFont(name: "Avenir-Medium", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: .medium)
        }
        return avenirFont
    }

}

extension UIFont {
    
    static let appFontName = "Inter"
    
    static func appFontBlack(_ size: CGFloat) -> UIFont {
        guard let appFont = UIFont(name: "\(self.appFontName)-Black", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: .black)
        }
        return appFont
    }
    
    static func appFontBold(_ size: CGFloat) -> UIFont {
        guard let appFont = UIFont(name: "\(self.appFontName)-Bold", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: .bold)
        }
        return appFont
    }
    
    static func appFontExtraBold(_ size: CGFloat) -> UIFont {
        guard let appFont = UIFont(name: "\(self.appFontName)-ExtraBold", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: .bold)
        }
        return appFont
    }
    
    static func appFontExtraLight(_ size: CGFloat) -> UIFont {
        guard let appFont = UIFont(name: "\(self.appFontName)-ExtraLight", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: .ultraLight)
        }
        return appFont
    }
    
    static func appFontLight(_ size: CGFloat) -> UIFont {
        guard let appFont = UIFont(name: "\(self.appFontName)-Light", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: .light)
        }
        return appFont
    }
    
    static func appFontMedium(_ size: CGFloat) -> UIFont {
        guard let appFont = UIFont(name: "\(self.appFontName)-Medium", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: .medium)
        }
        return appFont
    }
    
    static func appFontRegular(_ size: CGFloat) -> UIFont {
        guard let appFont = UIFont(name: "\(self.appFontName)-Regular", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: .regular)
        }
        return appFont
    }
    
    static func appFontSemiBold(_ size: CGFloat) -> UIFont {
        guard let appFont = UIFont(name: "\(self.appFontName)-SemiBold", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: .semibold)
        }
        return appFont
    }
    
    static func appFontThin(_ size: CGFloat) -> UIFont {
        guard let appFont = UIFont(name: "\(self.appFontName)-Thin", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: .semibold)
        }
        return appFont
    }

}
