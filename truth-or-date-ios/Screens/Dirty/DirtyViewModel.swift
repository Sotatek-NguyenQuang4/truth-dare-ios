//
//  DirtyViewModel.swift
//  truth-or-date-ios
//
//  Created by Nguyen Quang on 13/08/2022.
//

import Foundation
import SwiftFortuneWheel

class DirtyViewModel {
    var prizes: [String]
    var slices: [Slice]
    var categoryId: Topic?
    let playerManager: PlayerManager = PlayerManager.shared
    
    init() {
        self.prizes = playerManager.players.map { $0.name }
        self.slices = prizes.map({ Slice.init(contents: [Slice.ContentType.text(text: $0, preferences: .variousWheelSimpleText)]) })
    }
    
    func reloadData() {
        self.prizes = playerManager.players.map { $0.name }
        self.slices = prizes.map({ Slice.init(contents: [Slice.ContentType.text(text: $0, preferences: .variousWheelSimpleText)]) })
    }
    
    var finishIndex: Int {
        return Int.random(in: 0..<slices.count)
    }
}
