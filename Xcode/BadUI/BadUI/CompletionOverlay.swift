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
    @Environment(\.colorScheme) var colorScheme
    
    @State private var animatedStars = 0
    @State private var show = false
    
    private func resetState() {
        gameManager.showCompletion = false
        gameManager.timeElapsed = 0
        gameManager.currentLevel = nil
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .opacity(show ? 1 : 0)
                .animation(.easeInOut(duration: 0.3), value: show)
            
            VStack(spacing: 20) {
                Text("Level Complete!")
                    .font(.system(size: 32, weight: .bold))
                
                AnimatedStarRating(earnedStars: stars, mode: gameManager.currentLevel?.mode ?? "n")
                    .frame(height: 60)
                
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
                    Button(action: {
                        resetState()  
                        onMenu()
                    }) {
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
                    
                    Button(action: {
                        resetState()
                        onNext()
                    }) {
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
        }
    }
}

struct AnimatedStarRating: View {
    let earnedStars: Int
    let mode: String
    
    @State private var animatedStars: [Bool] = [false, false, false]
    @State private var pulseScales: [CGFloat] = [1.0, 1.0, 1.0]
    @State private var opacities: [Double] = [0.0, 0.0, 0.0]
    
    var body: some View {
        HStack(spacing: 16) {
            if mode == "c" {
                // Challenge mode - single red star
                ZStack {
                    // Pulse effect
                    Circle()
                        .fill(Color.red.opacity(opacities[0]))
                        .scaleEffect(pulseScales[0])
                    
                    // Star outline/fill
                    Image(systemName: animatedStars[0] ? "star.fill" : "star")
                        .foregroundColor(.red)
                        .font(.system(size: 36))
                }
                .frame(width: 60, height: 60)
            } else {
                // Normal mode - three yellow stars
                ForEach(0..<3) { index in
                    ZStack {
                        // Pulse effect
                        Circle()
                            .fill(Color.yellow.opacity(opacities[index]))
                            .scaleEffect(pulseScales[index])
                        
                        // Star outline/fill
                        Image(systemName: animatedStars[index] ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                            .font(.system(size: 30))
                    }
                    .frame(width: 50, height: 50)
                }
            }
        }
        .onAppear {
            startAnimation()
        }
    }
    
    private func startAnimation() {
        let totalStars = mode == "c" ? 1 : 3
        let animationDelay = 0.5 // 0.5 seconds between each star
        
        for i in 0..<min(earnedStars, totalStars) {
            // Schedule animation for this star
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * animationDelay) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    animatedStars[i] = true
                }
                
                // Start pulse animation
                withAnimation(.easeOut(duration: 0.5)) {
                    opacities[i] = 0.6
                    pulseScales[i] = 2.0
                }
                
                // Fade out pulse
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * animationDelay + 0.2) {
                    withAnimation(.easeOut(duration: 0.3)) {
                        opacities[i] = 0.0
                    }
                }
            }
        }
    }
}
