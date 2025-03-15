//  LevelSelectView.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import SwiftUI

struct LevelSelectView: View {
    @EnvironmentObject var gameManager: GameManager
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text(gameManager.currentWorld?.name ?? "Select Level")
                        .font(.largeTitle)
                        .padding()
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))]) {
                        if let levels = gameManager.currentWorld?.levels {
                            ForEach(levels, id: \.id) { level in
                                LevelCard(levelID: level.id)
                            }
                        }
                    }
                    .padding()
                }
            }
            .background(gradientBackground)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        gameManager.gameState = .worldSelect
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
