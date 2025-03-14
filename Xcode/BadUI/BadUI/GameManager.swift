//
//  GameManager.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import Combine
import SwiftUI

class GameManager: ObservableObject {
    // Add singleton instance
    static let shared = GameManager()
    
    @Published var gameWorlds: [World] = WorldConfig.worlds {
            didSet {
                // Prevent infinite recursion
                if gameWorlds != oldValue {
                    unlockWorlds()
                    calculateTotalStars()
                }
            }
        }
    
    enum GameState {
        case mainMenu, worldSelect, levelSelect, playing, levelComplete
    }
    
    @Published var earnedStars = 0
    @Published var timeElapsed = 0
    @Published var showCompletion = false
    
    @Published var gameState: GameState = .mainMenu
    @Published var currentWorld: World?
    @Published var currentLevel: Level?
    @Published var totalStars: Int = 0
    
    init() {
        calculateTotalStars()
        unlockInitialWorlds()
    }

    
    private func unlockInitialWorlds() {
            var modifiedWorlds = gameWorlds
            for i in modifiedWorlds.indices {
                modifiedWorlds[i].isLocked = modifiedWorlds[i].requiredStars > totalStars
            }
            if modifiedWorlds != gameWorlds {
                gameWorlds = modifiedWorlds
            }
        }
        
        func completeLevel(worldId: Int, levelId: String, stars: Int) {
            var modifiedWorlds = gameWorlds
            var didModify = false
            
            for worldIndex in modifiedWorlds.indices {
                guard modifiedWorlds[worldIndex].id == worldId else { continue }
                
                for levelIndex in modifiedWorlds[worldIndex].levels.indices {
                    guard modifiedWorlds[worldIndex].levels[levelIndex].id == levelId else { continue }
                    
                    // Update stars
                    let currentStars = modifiedWorlds[worldIndex].levels[levelIndex].stars ?? 0
                    if stars > currentStars {
                        modifiedWorlds[worldIndex].levels[levelIndex].stars = stars
                        didModify = true
                    }
                    
                    // Unlock next level
                    let nextIndex = levelIndex + 1
                    if nextIndex < modifiedWorlds[worldIndex].levels.count {
                        let required = modifiedWorlds[worldIndex].levels[nextIndex].requiredStars
                        let worldStars = modifiedWorlds[worldIndex].levels.reduce(0) { $0 + ($1.stars ?? 0) }
                        let wasLocked = modifiedWorlds[worldIndex].levels[nextIndex].isLocked
                        modifiedWorlds[worldIndex].levels[nextIndex].isLocked = worldStars < required
                        if wasLocked != modifiedWorlds[worldIndex].levels[nextIndex].isLocked {
                            didModify = true
                        }
                    }
                }
                
                // Update world lock status
                let wasLocked = modifiedWorlds[worldIndex].isLocked
                modifiedWorlds[worldIndex].isLocked = modifiedWorlds[worldIndex].requiredStars > totalStars
                if wasLocked != modifiedWorlds[worldIndex].isLocked {
                    didModify = true
                }
            }
            
            if didModify {
                gameWorlds = modifiedWorlds
            }
        }
        
        func unlockWorlds() {
            var modifiedWorlds = gameWorlds
            var didModify = false
            
            for i in modifiedWorlds.indices {
                let wasLocked = modifiedWorlds[i].isLocked
                modifiedWorlds[i].isLocked = modifiedWorlds[i].requiredStars > totalStars
                if wasLocked != modifiedWorlds[i].isLocked {
                    didModify = true
                }
            }
            
            if didModify {
                gameWorlds = modifiedWorlds
            }
        }
    
    private func calculateTotalStars() {
        totalStars = gameWorlds.reduce(0) { sum, world in
            sum + world.levels.reduce(0) { $0 + ($1.stars ?? 0) }
        }
    }
}

extension GameManager {
    func handleLevelCompletion(timeElapsed: Int, currentLevel: Level) {
        // Calculate stars
        var stars = 0
        if timeElapsed <= currentLevel.starThresholds["three"] ?? 0 {
            stars = 3
        } else if timeElapsed <= currentLevel.starThresholds["two"] ?? 0 {
            stars = 2
        } else if timeElapsed <= currentLevel.starThresholds["one"] ?? 0 {
            stars = 1
        }
        
        // Handle challenge mode
        if currentLevel.mode == "c" && timeElapsed <= currentLevel.starThresholds["one"] ?? 0 {
            let baseLevelId = currentLevel.id.replacingOccurrences(of: "+", with: "")
            if (currentWorld?.levels.first(where: { $0.id == baseLevelId })) != nil {
                completeLevel(worldId: currentWorld?.id ?? 0, levelId: baseLevelId, stars: 4)
            }
            stars = 0
        }
        
        // Save progress
        if let worldId = currentWorld?.id {
            completeLevel(worldId: worldId, levelId: currentLevel.id, stars: stars)
        }
        
        // Show completion overlay
        gameState = .levelComplete
    }
}
