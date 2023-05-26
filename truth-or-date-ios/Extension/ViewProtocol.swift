//
//  ViewProtocol.swift
//  Earable
//
//  Created by FPT Software on 6/1/22.
//  Copyright © 2022 Earable. All rights reserved.
//

import UIKit

protocol NibLoadable {
    static func getNibName() -> String
    static func getNib() -> UINib
}

extension NibLoadable where Self: UIView {
    static func getNibName() -> String {
        String(describing: self)
    }
    
    static func getNib() -> UINib {
        let mainBundle = Bundle.main
        return UINib(nibName: self.getNibName(), bundle: mainBundle)
    }
}
