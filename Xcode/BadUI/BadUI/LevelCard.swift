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
        VStack(alignment: .leading) {
            HStack {
                Text(level.title)
                    .font(.headline)
                
                Spacer()
                
                if level.isLocked {
                    Image(systemName: "lock")
                } else {
                    StarDisplay(stars: level.stars ?? 0, mode: level.mode)
                }
            }
            
            Text(level.description)
                .font(.caption)
            
            if level.isLocked {
                Text("\(level.requiredStars) stars needed")
                    .font(.caption2)
            }
        }
        .padding()
        .background(level.isLocked ? Color.gray : Color.blue)
        .cornerRadius(10)
    }
}

