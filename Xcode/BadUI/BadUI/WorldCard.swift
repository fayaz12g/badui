//
//  WorldCard.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import SwiftUI

struct WorldCard: View {
    let world: World
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(world.name)
                    .font(.title2.bold())
                    .foregroundColor(.white)
                
                Spacer()
                
                if world.isLocked {
                    Image(systemName: "lock")
                        .foregroundColor(.white)
                } else {
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("\(earnedStars)/\(totalPossibleStars)")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                }
            }
            
            Text(world.description)
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
                .lineLimit(2)
            
            if world.isLocked {
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("\(world.requiredStars) stars to unlock")
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.6))
                }
            }
        }
        .padding()
        .background(backgroundGradient)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(borderColor, lineWidth: 2)
        )
        .opacity(world.isLocked ? 0.8 : 1)
    }
    
    private var earnedStars: Int {
        world.levels.reduce(0) { $0 + ($1.stars ?? 0) }
    }
    
    private var totalPossibleStars: Int {
        world.levels.count * 3
    }
    
    private var backgroundGradient: some View {
        Group {
            if world.isLocked {
                LinearGradient(
                    gradient: Gradient(colors: [Color.gray, Color.gray.opacity(0.6)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            } else {
                LinearGradient(
                    gradient: Gradient(colors: world.id == 2 ?
                        [Color.orange, Color.orange.opacity(0.7)] :
                        [Color.red, Color.red.opacity(0.7)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            }
        }
    }
    
    private var borderColor: Color {
        world.isLocked ? Color.gray : (world.id == 2 ? Color.orange : Color.red)
    }
}
