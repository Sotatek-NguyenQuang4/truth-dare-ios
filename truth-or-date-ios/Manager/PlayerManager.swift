//
//  PlayerManager.swift
//  truth-or-date-ios
//
//  Created by Nguyen Quang on 13/08/2022.
//

import UIKit

class PlayerManager: NSObject {
    static let shared = PlayerManager()
    var players: [Player] = []
    let defaultPlayers: [Player] = [Player(name: "\("Home-player-default".localizedString()) 1"),
                                    Player(name: "\("Home-player-default".localizedString()) 2")]
    var questionDare: [String] = []
    var questionTruth: [String] = []

    override init() {
        
    }
    
    func cacheListPlayer(players: [Player]) {
        self.players = []
        self.players = players
    }
    
    func updateDare(list: [String]) {
        self.questionDare = list
    }
    
    func updateTruth(list: [String]) {
        self.questionTruth = list
    }
}
