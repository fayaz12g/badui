//
//  GameView.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        ZStack {
            
            // Main content
            Group {
                switch gameManager.gameState {
                case .mainMenu:
                    MainMenuView(onStart: {
                        gameManager.gameState = .worldSelect
                    })
                    
                case .worldSelect:
                    WorldSelectView()
                    
                case .levelSelect:
                    LevelSelectView()
                    
                case .playing:
                    if gameManager.currentLevel != nil {
                        GameContainerView()
                            .environmentObject(gameManager)
                    } else {
                        Text("No level selected")
                            .foregroundColor(.primary)
                    }
                    
                case .levelComplete:
                    if gameManager.currentLevel != nil {
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
            .transition(.opacity)
            
        }
    }
    
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
}

