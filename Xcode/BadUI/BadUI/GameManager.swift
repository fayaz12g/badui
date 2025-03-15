//
//  GameManager.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import Combine
import SwiftUI

class GameManager: ObservableObject {
    
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

    
    // When starting a level:
    func startLevel(_ level: Level) {
        currentLevel = level
        timeElapsed = 0
        showCompletion = false
        gameState = .playing
    }

    // When completing a level:
    private func showCompletionOverlay() {
        gameState = .levelComplete
        showCompletion = true
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
            
            // Add this to get reference to the world we're modifying
            var modifiedWorld = modifiedWorlds[worldIndex]
            
            for levelIndex in modifiedWorld.levels.indices {
                guard modifiedWorld.levels[levelIndex].id == levelId else { continue }
                
                // Update stars
                let currentStars = modifiedWorld.levels[levelIndex].stars ?? 0
                if stars > currentStars {
                    modifiedWorld.levels[levelIndex].stars = stars
                    didModify = true
                }
                
                // Unlock next level
                let nextIndex = levelIndex + 1
                if nextIndex < modifiedWorld.levels.count {
                    let required = modifiedWorld.levels[nextIndex].requiredStars
                    let worldStars = modifiedWorld.levels.reduce(0) { $0 + ($1.stars ?? 0) }
                    let wasLocked = modifiedWorld.levels[nextIndex].isLocked
                    modifiedWorld.levels[nextIndex].isLocked = worldStars < required
                    if wasLocked != modifiedWorld.levels[nextIndex].isLocked {
                        didModify = true
                    }
                }
            }
            
            // Update the modified world in the array
            modifiedWorlds[worldIndex] = modifiedWorld
            
            // Update currentWorld reference if needed
            if modifiedWorld.id == currentWorld?.id {
                currentWorld = modifiedWorld
            }
        }
        
        if didModify {
            gameWorlds = modifiedWorlds
            calculateTotalStars() // Force total stars recalculation
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
    func handleLevelCompletion(timeElapsed: Int) {
        guard let currentLevel = currentLevel else {
            print("No current level set")
            return
        }
        
        self.timeElapsed = timeElapsed
        
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
        
        // Update earned stars for overlay
        earnedStars = stars
        showCompletion = true
        
        // reset
        self.timeElapsed = 0
    }
}
