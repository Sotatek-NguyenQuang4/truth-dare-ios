//
//  HomeViewModel.swift
//  truth-or-date-ios
//
//  Created by Nguyen Quang on 12/08/2022.
//

import Foundation

class HomeViewModel {
    var players: [Player]
    let maxPlayer: Int = 8
    var navigationState: NavigationState = .navigate
    let playerManager: PlayerManager = PlayerManager.shared
    
    init() {
        self.players = playerManager.players.count == 0 ? playerManager.defaultPlayers : playerManager.players
    }
    
    func addPlayer(player: Player) {
        self.players.append(player)
    }
    
    func removePlayer(index: Int) {
        self.players.remove(at: index)
    }
}

struct Player {
    var name: String
}

enum NavigationState {
    case navigate
    case present
}
