//
//  UIColor.swift

import UIKit
extension UIColor {
    enum Basic {
        static let white = UIColor.white
        static let black = UIColor.black
        static let clear = UIColor.clear
        static let primary = UIColor(hexString: "#0D0F1E")
        static let secondary = UIColor(hexString: "#122952")
        static let red = UIColor(hexString: "#DD2121")
        static let unselected = UIColor(hexString: "#6D6D6D")
        static let background = UIColor(hexString: "E5E5E5")
        static let orange = UIColor(hexString: "FF7B00")
        static let black75 = UIColor(hexString: "000000", alpha: 0.7)
        static let gray = UIColor(hexString: "979797")
        static let bgPopUp = UIColor(hexString: "C4C4C4", alpha: 0.5)
    }
    
    enum Profile {
        static let bgButtonEdit = UIColor.init(hexString: "FFFFFF", alpha: 0.3)
        static let opacityBanner = UIColor.init(hexString: "000000", alpha: 0.4)
        static let textStateVip = UIColor.init(hexString: "FFC107")
        static let tabSectionActive = UIColor.init(hexString: "252A34")
        static let tabSection = UIColor.init(hexString: "838B9F")
        static let tabSectionBorder = UIColor.init(hexString: "D6D9DE")
        static let borderlistChapter = UIColor.init(hexString: "DCDBDB")
        static let separationListChapter = UIColor.init(hexString: "000000", alpha: 0.8)
    }
    
    enum Home {
        static let green = UIColor(hexString: "046B7E")
        static let borderStory = UIColor(hexString: "000000", alpha: 0.2)
        static let placeholderColor = UIColor(hexString: "000000", alpha: 0.6)
        static let horizontalWithBanner = UIColor(hexString: "E7F2E1")
        static let buttonReading = UIColor(hexString: "BCCFB3")
    }
    
    enum Background {
        static let buttonNormal = UIColor(hexString: "#FFB30F")
        static let buttonSelected = UIColor(hexString: "#6C34FB")
        static let lightRed = UIColor(hexString: "#DF2354")
        static let menuBarItemSelected = UIColor(hexString: "#D42856")
        static let editText = UIColor(hexString: "#000000",
                                      alpha: 0.6)
        static let navigationBar = UIColor(hexString: "#F2F2F7")
        static let navigationBarSpace = UIColor(hexString: "#BDBDBF")
        static let collageOption = UIColor(hexString: "#D94269")
        static let view = UIColor(hexString: "#D94269")
    }
    
    enum Text {
        static let normal = UIColor.black
        static let selected = UIColor.darkText
    }
    
    enum Registration {
        static let buttonLogInSignUpTextColor = UIColor(hexString: "#D07A00")
        static let buttonLogInSignUpBorderColor = UIColor(hexString: "#D07A00")
        static let textFieldBorderColor = UIColor(hexString: "#CFCFCF")
        static let textFieldTextColor = UIColor(hexString: "#CFCFCF")
    }
    
    enum SideMenu {
        static let textColor = UIColor(hexString: "#D1D1D1")
        static let saperatorLine = UIColor(hexString: "#D1D1D1")
    }
    
    enum OrderHistory {
        static let saperatorLine = UIColor(hexString: "#B3B3B3")
        static let statusText = UIColor(hexString: "#D07A00")
        static let dateCreateOrder = UIColor(hexString: "#848484")
        static let buttonViewOrder = UIColor(hexString: "#D07A00")
        static let background = UIColor(hexString: "#E5E5E5")
    }
    
    enum ShoppingCart {
        static let backgroundFooter = UIColor(hexString: "#E9E0E0")
        static let saperatorLine = UIColor(hexString: "#979797")
        static let buttonCheckout = UIColor(hexString: "#9A5B05")
        static let borderDiscount = UIColor(hexString: "#C4C4C4")
    }
    
    enum ProductInformation {
        static let saperatorLine = UIColor(hexString: "#D1D1D1")
        static let indicatorColor = UIColor(hexString: "#DF2354")
    }
    
    enum CreateDesign {
        static let selectedBorder = UIColor(hexString: "#DF2354")
        static let defaultTextBorder = UIColor(hexString: "#6BE9D4")
    }
    
    enum BuyScreen {
        static let buttonBuyBackGround = UIColor(hexString: "#9A5B05")
    }
}

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexint = Int(UIColor.intFromHexString(hexStr: hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        // Create color object, specifying alpha as well
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    static func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = NSCharacterSet(charactersIn: "#") as CharacterSet
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
    
    func hexStringFromColor() -> String {
        let components = self.cgColor.components
        let red: CGFloat = components?[0] ?? 0.0
        let green: CGFloat = components?[1] ?? 0.0
        let blue: CGFloat = components?[2] ?? 0.0

        let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(red * 255)), lroundf(Float(green * 255)), lroundf(Float(blue * 255)))
        return hexString
     }
}
