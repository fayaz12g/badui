//  WorldSelectView.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import SwiftUI

struct WorldSelectView: View {
    @EnvironmentObject var gameManager: GameManager
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Select World")
                        .font(.largeTitle)
                        .padding()
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))]) {
                        ForEach(gameManager.gameWorlds) { world in
                            WorldCard(world: world)
                                .onTapGesture {
                                    if !world.isLocked {
                                        gameManager.currentWorld = world
                                        gameManager.gameState = .levelSelect
                                    }
                                }
                        }
                    }
                    .padding()
                }
                .overlay(alignment: .topTrailing) {
                    StarCounter(totalStars: gameManager.totalStars)
                }
            }
            .background(gradientBackground)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        gameManager.gameState = .mainMenu
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
    
    var gradientBackground: LinearGradient {
        if colorScheme == .dark {
            return LinearGradient(
                gradient: Gradient(colors: [Color.black, Color.gray]),
                startPoint: .top,
                endPoint: .bottom
            )
        } else {
            return LinearGradient(
                gradient: Gradient(colors: [Color.white, Color.gray.opacity(0.5)]),
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
}

struct StarCounter: View {
    let totalStars: Int
    
    var body: some View {
        HStack {
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
            Text("\(totalStars)")
                .font(.title)
        }
        .padding()
    }
}
