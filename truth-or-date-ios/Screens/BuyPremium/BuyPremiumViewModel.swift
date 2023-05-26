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

struct Purchase: Codable {
    let title: String
    let body: String
    let paymentId: String
    let price: String
    
    init(title: String, paymentId: String, price: String) {
        self.title = title
        self.body = ""
        self.paymentId = paymentId
        self.price = price
    }
}
