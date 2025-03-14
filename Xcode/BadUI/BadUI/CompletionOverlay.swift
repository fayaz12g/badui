//
//  CompletionOverlay.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import SwiftUI

struct CompletionOverlay: View {
    @EnvironmentObject var gameManager: GameManager
    let timeElapsed: Int
    let stars: Int
    let nextLevel: Level?
    let isNextLevelUnlocked: Bool
    let onNext: () -> Void
    let onReplay: () -> Void
    let onMenu: () -> Void
    
    @State private var animatedStars = 0
    @State private var show = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .opacity(show ? 1 : 0)
                .animation(.easeInOut(duration: 0.3), value: show)
            
            VStack(spacing: 20) {
                Text("Level Complete!")
                    .font(.system(size: 32, weight: .bold))
                
                StarRating(stars: animatedStars, mode: gameManager.currentLevel?.mode ?? "n")
                    .frame(height: 40)
                
                Text("Time: \(timeElapsed)s")
                    .font(.title2)
                
                if let nextLevel = nextLevel {
                    VStack {
                        Text(isNextLevelUnlocked ? "Next Level:" : "Locked:")
                            .font(.headline)
                        
                        Text(nextLevel.title)
                            .font(.title3)
                        
                        if !isNextLevelUnlocked {
                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                Text("\(nextLevel.requiredStars - gameManager.totalStars) more stars needed")
                            }
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                }
                
                HStack(spacing: 20) {
                    Button(action: onMenu) {
                        HStack {
                            Image(systemName: "list.bullet")
                            Text("Levels")
                        }
                    }
                    .buttonStyle(SecondaryButtonStyle())
                    
                    Button(action: onReplay) {
                        HStack {
                            Image(systemName: "arrow.clockwise")
                            Text("Retry")
                        }
                    }
                    .buttonStyle(SecondaryButtonStyle())
                    
                    Button(action: onNext) {
                        HStack {
                            Image(systemName: "arrow.right")
                            Text(nextLevel == nil ? "Menu" : "Next")
                        }
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    .disabled(nextLevel != nil && !isNextLevelUnlocked)
                }
            }
            .padding(30)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.systemBackground))
                    .shadow(radius: 10)
            )
            .scaleEffect(show ? 1 : 0.8)
            .opacity(show ? 1 : 0)
            .animation(.spring(response: 0.4, dampingFraction: 0.6), value: show)
        }
        .onAppear {
            show = true
            animateStars()
        }
    }
    
    private func animateStars() {
        withAnimation(.easeInOut(duration: 1.5)) {
            animatedStars = stars
        }
    }
}

struct StarRating: View {
    let stars: Int
    let mode: String
    
    var body: some View {
        HStack {
            ForEach(0..<3) { index in
                Image(systemName: index < stars ? "star.fill" : "star")
                    .foregroundColor(starColor(for: index))
                    .scaleEffect(index < stars ? 1.2 : 1.0)
            }
        }
    }
    
    private func starColor(for index: Int) -> Color {
        if mode == "c" {  // Challenge mode
            return index == 3 ? .yellow : .gray
        }
        return [.yellow, .yellow, .yellow][index]
    }
}
