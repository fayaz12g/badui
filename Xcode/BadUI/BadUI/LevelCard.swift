//
//  LevelCard.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import SwiftUI

struct LevelCard: View {
    let level: Level
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        Button {
            guard !level.isLocked else { return }
            gameManager.currentLevel = level
            gameManager.gameState = .playing
        } label: {
            VStack(alignment: .leading) {
                HStack {
                    Text(level.title)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    if level.isLocked {
                        Image(systemName: "lock")
                            .foregroundColor(.white)
                    } else {
                        StarDisplay(stars: level.stars ?? 0, mode: level.mode)
                    }
                }
                
                Text(level.description)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
                
                if level.isLocked {
                    Text("\(level.requiredStars) stars needed")
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.6))
                }
            }
            .padding()
            .background(
                level.isLocked ?
                Color.gray.opacity(0.3) :
                    (level.mode == "c" ? Color.red : Color.blue)
            )
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(level.mode == "c" ? Color.red : Color.blue, lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
       .disabled(level.isLocked)
    }
}

