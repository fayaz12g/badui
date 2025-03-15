//
//  GameManager.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import Combine
import SwiftUI

class GameManager: ObservableObject {
    private let saveKey = "SavedGameState"
    
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
        loadGameState()
        calculateTotalStars()
        unlockInitialWorlds()
    }

    private func loadGameState() {
        guard let data = UserDefaults.standard.data(forKey: saveKey),
              let decoded = try? JSONDecoder().decode(SavedGameState.self, from: data) else {
            return
        }
        
        gameWorlds = decoded.worlds
        totalStars = decoded.totalStars
    }

    func saveGameState() {
        let state = SavedGameState(
            worlds: gameWorlds,
            totalStars: totalStars
        )
        
        if let encoded = try? JSONEncoder().encode(state) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }

    private struct SavedGameState: Codable {
        let worlds: [World]
        let totalStars: Int
    }
    
    func getLevelView() -> AnyView {
            guard let level = currentLevel else { return AnyView(EmptyView()) }
            return LevelViewFactory.view(for: level)
        }
    
    func startLevel(_ level: Level) {
        currentLevel = level
        timeElapsed = 0
        showCompletion = false  // Add this line
        gameState = .playing
    }

    func resetLevel() {
        showCompletion = false
        timeElapsed = 0
        currentLevel = currentLevel  // Force view refresh
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
            
            var modifiedWorld = modifiedWorlds[worldIndex]
            var worldModified = false
            
            // Update stars for the completed level
            if let levelIndex = modifiedWorld.levels.firstIndex(where: { $0.id == levelId }) {
                let currentStars = modifiedWorld.levels[levelIndex].stars ?? 0
                if stars > currentStars {
                    modifiedWorld.levels[levelIndex].stars = stars
                    didModify = true
                    worldModified = true
                }
            }
            
            // Calculate total stars for the world
            _ = modifiedWorld.levels.reduce(0) { $0 + ($1.stars ?? 0) }
            
            // Unlock all levels that meet requirements
            for levelIndex in modifiedWorld.levels.indices {
                let required = modifiedWorld.levels[levelIndex].requiredStars
                let wasLocked = modifiedWorld.levels[levelIndex].isLocked
                
                // Unlock if either:
                // 1. Player has enough total stars globally OR
                // 2. Previous level was completed (linear progression)
                let shouldUnlock = self.totalStars >= required ||
                (levelIndex > 0 && modifiedWorld.levels[levelIndex-1].stars ?? 0 > 0)
                
                modifiedWorld.levels[levelIndex].isLocked = !shouldUnlock
                
                if wasLocked != modifiedWorld.levels[levelIndex].isLocked {
                    didModify = true
                    worldModified = true
                }
            }
            
            if worldModified {
                modifiedWorlds[worldIndex] = modifiedWorld
                if modifiedWorld.id == currentWorld?.id {
                    currentWorld = modifiedWorld
                }
            }
        }
        
        if didModify {
            gameWorlds = modifiedWorlds
            calculateTotalStars()
            unlockWorlds() // Make sure this updates world locked status
        }
    }
        
    func unlockWorlds() {
        var modifiedWorlds = gameWorlds
        for i in modifiedWorlds.indices {
            let wasLocked = modifiedWorlds[i].isLocked
            modifiedWorlds[i].isLocked = modifiedWorlds[i].requiredStars > totalStars
            if wasLocked != modifiedWorlds[i].isLocked {
                gameWorlds = modifiedWorlds
                return
            }
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
