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
    
    
    // Function to check if challenge level exists and get its ID
    private func getChallengeLevel() -> Level? {
        // If this is already a challenge level, return nil
        if level.mode == "c" { return nil }
        
        // Find the corresponding challenge level by adding "+" to the ID
        let challengeId = level.id + "+"
        return gameManager.currentWorld?.levels.first(where: { $0.id == challengeId && $0.mode == "c" })
    }
    
    // Function to check if challenge is unlocked (normal level has at least 1 star)
    private func isChallengeUnlocked() -> Bool {
        return (level.stars ?? 0) >= 1
    }
    
    var body: some View {
        // Only show the card if it's not a challenge level or if debugging
        if level.mode != "c" {
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
                        StarDisplay(stars: level.stars ?? 0, mode: level.mode, challengeStars: getChallengeLevel()?.stars ?? 0, showChallengeStars: isChallengeUnlocked())
                    }
                }
                
                Text(level.description)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
                
                if level.isLocked {
                    Text("\(level.requiredStars) stars needed")
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.6))
                } else {
                    // Button layout
                    HStack {
                        // Regular level button
                        Button {
                            gameManager.currentLevel = level
                            gameManager.gameState = .playing
                        } label: {
                            Text("Play Level")
                                .padding(.vertical, 8)
                                .padding(.horizontal, 12)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        
                        // Challenge level button - only show if unlocked
                        if isChallengeUnlocked(), let challengeLevel = getChallengeLevel() {
                            Button {
                                gameManager.currentLevel = challengeLevel
                                gameManager.gameState = .playing
                            } label: {
                                Text("Challenge")
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 12)
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
            }
            .padding()
            .background(
                level.isLocked ?
                Color.gray.opacity(0.3) :
                Color.blue.opacity(0.7)
            )
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.blue, lineWidth: 1)
            )
        }
    }
}
