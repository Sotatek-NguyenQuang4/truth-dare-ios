//
//  SFWConfiguration+VariousWheelSimple.swift
//  truth-or-date-ios
//
//  Created by Nguyen Quang on 13/08/2022.
//

import UIKit
import SwiftFortuneWheel

public extension SFWConfiguration {
    static var variousWheelSimpleConfiguration: SFWConfiguration {
        
        let colors = [#colorLiteral(red: 0.2041620612, green: 0.3005031645, blue: 0.3878828585, alpha: 1),
                      #colorLiteral(red: 0.2041620612, green: 0.3005031645, blue: 0.3878828585, alpha: 1),
                      #colorLiteral(red: 0.2041620612, green: 0.3005031645, blue: 0.3878828585, alpha: 1),
                      #colorLiteral(red: 0.2041620612, green: 0.3005031645, blue: 0.3878828585, alpha: 1),
                      #colorLiteral(red: 0.2041620612, green: 0.3005031645, blue: 0.3878828585, alpha: 1),
                      #colorLiteral(red: 0.2041620612, green: 0.3005031645, blue: 0.3878828585, alpha: 1),
                      #colorLiteral(red: 0.2041620612, green: 0.3005031645, blue: 0.3878828585, alpha: 1),
                      #colorLiteral(red: 0.2041620612, green: 0.3005031645, blue: 0.3878828585, alpha: 1)]
        
        let pin = SFWConfiguration.PinImageViewPreferences(size: CGSize(width: 30, height: 50),
                                                           position: .top,
                                                           verticalOffset: -20)
        
        let sliceColorType = SFWConfiguration.ColorType.customPatternColors(colors: colors,
                                                                            defaultColor: .white)
        
        let slicePreferences = SFWConfiguration.SlicePreferences(backgroundColorType: sliceColorType,
                                                                 strokeWidth: 3,
                                                                 strokeColor: .white)
        
        let circlePreferences = SFWConfiguration.CirclePreferences(strokeWidth: 7,
                                                                   strokeColor: .white)
        
        let wheelPreferences = SFWConfiguration.WheelPreferences(circlePreferences: circlePreferences,
                                                                 slicePreferences: slicePreferences,
                                                                 startPosition: .top)
        
        let configuration = SFWConfiguration(wheelPreferences: wheelPreferences,
                                             pinPreferences: pin)
        
        return configuration
    }
}

public extension TextPreferences {
    static var variousWheelSimpleText: TextPreferences {
        let textPreferences = TextPreferences(textColorType: SFWConfiguration.ColorType.customPatternColors(colors: nil,
                                                                                                            defaultColor: .white),
                                              font: UIFont.init(name: "Chalkduster", size: 14) ?? .systemFont(ofSize: 14),
                                              verticalOffset: 8)
        return textPreferences
    }
}
