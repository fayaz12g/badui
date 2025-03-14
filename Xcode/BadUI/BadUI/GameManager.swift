//
//  GameManager.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//


import Combine
import SwiftUI

class GameManager: ObservableObject {
    enum GameState {
        case mainMenu, worldSelect, levelSelect, playing
    }
    
    @Published var gameState: GameState = .mainMenu
    @Published var currentWorld: World?
    @Published var currentLevel: Level?
    @Published var gameWorlds: [World] = WorldConfig.worlds
    @Published var totalStars: Int = 0
    
    init() {
        calculateTotalStars()
        unlockInitialWorlds()
    }
    
    private func unlockInitialWorlds() {
        gameWorlds = gameWorlds.map { world in
            var modifiedWorld = world
            modifiedWorld.isLocked = world.requiredStars > totalStars
            return modifiedWorld
        }
    }
    
    private func calculateTotalStars() {
        totalStars = gameWorlds.reduce(0) { sum, world in
            sum + world.levels.reduce(0) { $0 + ($1.stars ?? 0) }
        }
    }
    
    func completeLevel(worldId: Int, levelId: String, stars: Int) {
        gameWorlds = gameWorlds.map { world in
            guard world.id == worldId else { return world }
            
            var modifiedWorld = world
            modifiedWorld.levels = modifiedWorld.levels.map { level in
                guard level.id == levelId else { return level }
                
                var modifiedLevel = level
                modifiedLevel.stars = max(level.stars ?? 0, stars)
                return modifiedLevel
            }
            
            // Unlock next level if needed
            if let currentLevelIndex = modifiedWorld.levels.firstIndex(where: { $0.id == levelId }) {
                let nextLevelIndex = currentLevelIndex + 1
                if nextLevelIndex < modifiedWorld.levels.count {
                    var nextLevel = modifiedWorld.levels[nextLevelIndex]
                    let worldStars = modifiedWorld.levels.reduce(0) { $0 + ($1.stars ?? 0) }
                    nextLevel.isLocked = worldStars < nextLevel.requiredStars
                    modifiedWorld.levels[nextLevelIndex] = nextLevel
                }
            }
            
            // Unlock world if needed
            modifiedWorld.isLocked = modifiedWorld.requiredStars > totalStars
            
            return modifiedWorld
        }
        
        calculateTotalStars()
    }
    
    func unlockWorlds() {
        gameWorlds = gameWorlds.map { world in
            var modifiedWorld = world
            modifiedWorld.isLocked = world.requiredStars > totalStars
            return modifiedWorld
        }
    }
}
