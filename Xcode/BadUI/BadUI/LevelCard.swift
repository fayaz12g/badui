//
//  LevelCard.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import SwiftUI

struct LevelCard: View {
    let levelID: String
    @EnvironmentObject var gameManager: GameManager
    
    private var level: Level? {
        gameManager.currentWorld?.levels.first { $0.id == levelID }
    }
    
    private func getChallengeLevel() -> Level? {
        guard let level = level, level.mode != "c" else { return nil }
        let challengeId = level.id + "+"
        return gameManager.currentWorld?.levels.first { $0.id == challengeId && $0.mode == "c" }
    }
    
    private func isChallengeUnlocked() -> Bool {
        (level?.stars ?? 0) >= 1
    }
    
    private func handleLevelSelection(_ level: Level) {
        gameManager.currentLevel = level
        gameManager.gameState = .playing
    }
    
    var body: some View {
        Group {
            if let level = level, level.mode != "c" {
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
                            StarDisplay(
                                stars: level.stars ?? 0,
                                mode: level.mode,
                                challengeStars: getChallengeLevel()?.stars ?? 0,
                                showChallengeStars: isChallengeUnlocked()
                            )
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
                    else {
                  
                        // Challenge unlocked: Show buttons
                        if isChallengeUnlocked(), let challengeLevel = getChallengeLevel() {
                            HStack {
                                Button {
                                    handleLevelSelection(level)
                                } label: {
                                    Text("Replay")
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 12)
                                        .background(Color.yellow)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                
                                Button {
                                    handleLevelSelection(challengeLevel)
                                } label: {
                                    Text("Challenge")
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 12)
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                            }
                            .padding(.top, 4)
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
                .overlay {
                    if !level.isLocked {
                        // Challenge locked: Whole card is button
                        if !isChallengeUnlocked() {
                            Button {
                                handleLevelSelection(level)
                            } label: {
                                Color.clear
                                    .contentShape(Rectangle())
                            }
                        }
                    }
                }
            }
        }
    }
}
