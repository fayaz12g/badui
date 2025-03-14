//
//  WorldSelectView.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import SwiftUI

struct WorldSelectView: View {
    @EnvironmentObject var gameManager: GameManager
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
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
