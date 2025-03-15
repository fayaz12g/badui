//
//  GameHeaderView.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import SwiftUI

struct GameHeaderView: View {
    @EnvironmentObject var gameManager: GameManager
    @State private var localTimeElapsed = 0
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Environment(\.colorScheme) var colorScheme
    
    private var backgroundGradient: LinearGradient {
        if gameManager.currentLevel?.mode == "c" {
            // Challenge level - red background
            return LinearGradient(
                gradient: Gradient(colors: [
                    Color.red.opacity(0.8),
                    Color.red.opacity(0.6)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        } else {
            // Normal level - gray background based on color scheme
            if colorScheme == .dark {
                return LinearGradient(
                    gradient: Gradient(colors: [
                        Color.gray.opacity(0.8),
                        Color.gray.opacity(0.6)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            } else {
                return LinearGradient(
                    gradient: Gradient(colors: [
                        Color.gray.opacity(0.3),
                        Color.gray.opacity(0.2)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
        }
    }
    
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
                    Text("\(localTimeElapsed)s")
                        .font(.system(.body, design: .monospaced))
                        .onReceive(timer) { _ in
                            if gameManager.gameState == .playing {
                                localTimeElapsed = gameManager.timeElapsed
                            }
                        }
                }
            }
            .padding()
            .background(backgroundGradient)
        }
    }
