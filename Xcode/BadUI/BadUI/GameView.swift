//
//  GameView.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//


import SwiftUI

struct GameView: View {
    @EnvironmentObject var gameManager: GameManager
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        ZStack {
            themeManager.isDarkMode ? Color.black : Color.white
            
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
                    if let level = gameManager.currentLevel {
                        level.view
                    }
                }
            }
            .transition(.opacity)
            
            ThemeToggle()
        }
    }
}
