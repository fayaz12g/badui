//
//  GameContainerView.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//


import SwiftUI

struct GameContainerView: View {
    @EnvironmentObject var gameManager: GameManager
    
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
                    LevelView(level: level)
                        .transition(.opacity)
                }
                
                Spacer()
            }
        }
    }
}
