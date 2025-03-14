//
//  GameHeaderView.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import SwiftUI

struct GameHeaderView: View {
    @EnvironmentObject var gameManager: GameManager
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            // Back Button
            Button {
                gameManager.gameState = .levelSelect
                gameManager.currentLevel = nil
            } label: {
                Image(systemName: "arrow.left")
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Circle())
            }
            
            // Level Title
            Text(gameManager.currentLevel?.title ?? "")
                .font(.title2.bold())
                .foregroundColor(colorScheme == .dark ? .white : .black)
            
            Spacer()
            
            // Timer
            HStack(spacing: 8) {
                Image(systemName: "timer")
                    .foregroundColor(.gray)
                Text("\(gameManager.timeElapsed)s")
                    .font(.system(.body, design: .monospaced))
                    .foregroundColor(colorScheme == .dark ? .white : .black)
            }
        }
        .padding()
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.red.opacity(0.8),
                    Color.red.opacity(0.6)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}
