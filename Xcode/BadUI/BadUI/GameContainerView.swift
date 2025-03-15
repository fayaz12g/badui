//
//  GameContainerView.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//


import SwiftUI

struct GameContainerView: View {
    @EnvironmentObject var gameManager: GameManager
    
    private var nextLevel: Level? {
        guard let world = gameManager.currentWorld,
              let currentLevel = gameManager.currentLevel,
              let index = world.levels.firstIndex(where: { $0.id == currentLevel.id }),
              index + 1 < world.levels.count else {
            return nil
        }
        return world.levels[index + 1]
    }
    
    private var isNextLevelUnlocked: Bool {
        guard let nextLevel = nextLevel else { return false }
        return gameManager.totalStars >= nextLevel.requiredStars
    }
    
    private func handleNextLevel() {
        guard let nextLevel = nextLevel else { return }
        gameManager.currentLevel = nextLevel
        gameManager.showCompletion = false
        gameManager.timeElapsed = 0
    }

    private func resetLevel() {
        gameManager.showCompletion = false
        gameManager.timeElapsed = 0
    }

    private func returnToLevelSelect() {
        gameManager.gameState = .levelSelect
        gameManager.currentLevel = nil
    }
    
    var body: some View {
        ZStack {
            // Background based on world
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.red.opacity(0.8),
                    Color.red.opacity(0.6)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            
            VStack {
                GameHeaderView()
                
                if let level = gameManager.currentLevel {
                    level.view
                }
                
                Spacer()
            }
            
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
}
