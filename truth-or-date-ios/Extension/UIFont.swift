//
//  UIFont.swift

import UIKit

extension UIFont {
    
    enum FontStyles {
        case regular, italic, light, lightItalic, bold, boldItalic, medium, mediumItalic
        var name: String {
            switch self {
            case .regular:              return "Cabin-Regular"
            case .italic:               return "Cabin-Italic"
            case .light:                return "Cabin-Light"
            case .lightItalic:          return "Cabin-LightItalic"
            case .bold:                 return "Cabin-Bold"
            case .boldItalic:           return "Cabin-BoldItalic"
            case .medium:               return "Cabin-Medium"
            case .mediumItalic:         return "Cabin-MediumItalic"
            }
        }
    }
    
    static func font(style: FontStyles, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: style.name, size: size) else {
            // If we don't have the font, let's return at least the system's default on the requested size
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
        
    static func primary(size: CGFloat = 16) -> UIFont {
        font(style: .regular, size: size)
    }
    
    static func important(size: CGFloat = 16) -> UIFont {
        font(style: .bold, size: size)
    }
    
    static func medium(size: CGFloat = 16) -> UIFont {
        font(style: .medium, size: size)
    }
    
    static func mediumItalic(size: CGFloat = 16) -> UIFont {
        font(style: .mediumItalic, size: size)
    }
    
    static func boldItalic(size: CGFloat = 16) -> UIFont {
        font(style: .boldItalic, size: size)
    }
}
