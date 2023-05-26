//
//  BasicViewController.swift
//  truth-or-date-ios
//
//  Created by Nguyen Quang on 13/08/2022.
//

import UIKit

class BasicViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
    }
}
