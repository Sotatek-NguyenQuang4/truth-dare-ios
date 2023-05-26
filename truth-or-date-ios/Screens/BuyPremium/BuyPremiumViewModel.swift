//
//  BuyPremiumViewModel.swift
//  truth-or-date-ios
//
//  Created by Nguyen Quang on 13/08/2022.
//

import Foundation
import UIKit

class BuyPremiumViewModel {
    
    var id: String
    
    init(id: String) {
        self.id = id
    }
    
}

enum Purchase: CaseIterable {
    case dirty
    case all
    
    var title: String {
        switch self {
        case .dirty:
            return "DIRT +"
        case .all:
            return "ALL CONTENT"
        }
    }
    
    var body: String {
        switch self {
        case .dirty:
            return "Turn up the heat and bring the night to a whole new leve. Contains 500+ cards."
        case .all:
            return "Buy both Dirty+ and Dirty Extrene abd save 900000.00 đ. Most value"
        }
    }
    
    var background: UIColor? {
        switch self {
        case .dirty:
            return .init(hexString: "DDDDDD")
        case .all:
            return .clear
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .dirty:
            return UIImage(named: "img_dirty")
        case .all:
            return UIImage(named: "img_all")
        }
    }
    
    var price: String {
        switch self {
        case .dirty:
            return "0.99$"
        case .all:
            return "3.99$"
        }
    }
    
    var paymentId: String {
        switch self {
        case .dirty:
            return "com.thanh.phantruth.or.dare.dirt"
        case .all:
            return "com.thanh.phantruth.or.dare.all.content"
        }
    }
}
