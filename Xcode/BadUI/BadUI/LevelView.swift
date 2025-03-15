//
//  LevelView.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import SwiftUI

struct LevelView: View {
    @EnvironmentObject var gameManager: GameManager
    let level: Level
    

    private var nextLevel: Level? {
        guard let world = gameManager.currentWorld,
              let currentIndex = world.levels.firstIndex(where: { $0.id == level.id }),
              currentIndex + 1 < world.levels.count else {
            return nil
        }
        return world.levels[currentIndex + 1]
    }
    
    private var isNextLevelUnlocked: Bool {
        guard let nextLevel = nextLevel else { return false }
        return gameManager.totalStars >= nextLevel.requiredStars
    }
    
    var body: some View {
        ZStack {
            // Level Content
            gameManager.getLevelView()
            
            // Completion Overlay
            if gameManager.showCompletion {
                CompletionOverlay(
                    timeElapsed: gameManager.timeElapsed,
                    stars: gameManager.earnedStars,
                    nextLevel: nextLevel,
                    isNextLevelUnlocked: isNextLevelUnlocked,
                    onNext: handleNextLevel,
                    onReplay: resetLevel,
                    onMenu: returnToLevelSelect
                )
            }
        }
    }
    
    private func handleNextLevel() {
        guard let world = gameManager.currentWorld else { return }
        
        // Complete current level
        gameManager.completeLevel(
            worldId: world.id,
            levelId: level.id,
            stars: gameManager.earnedStars
        )
        
        // Get next level
        guard let currentIndex = world.levels.firstIndex(where: { $0.id == level.id }),
              currentIndex + 1 < world.levels.count else {
            returnToLevelSelect()
            return
        }
        
        let nextLevel = world.levels[currentIndex + 1]
        
        // Check if next level is unlocked
        if gameManager.totalStars >= nextLevel.requiredStars {
            gameManager.currentLevel = nextLevel
            resetLevel()
        } else {
            returnToLevelSelect()
        }
    }
    
    private func resetLevel() {
        gameManager.showCompletion = false
        gameManager.timeElapsed = 0
        gameManager.currentLevel = nil
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            gameManager.currentLevel = level  // Force view recreation
        }
    }
    
    private func returnToLevelSelect() {
        gameManager.gameState = .levelSelect
        gameManager.currentLevel = nil
    }
}
