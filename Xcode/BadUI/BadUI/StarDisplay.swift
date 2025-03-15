//
//  StarDisplay.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import SwiftUI

struct StarDisplay: View {
    let stars: Int
    let mode: String
    let showChallengeStars: Bool
    
    var body: some View {
        HStack(spacing: 4) {
            
            // Normal mode stars
            ForEach(0..<3) { index in
                Image(systemName: index < stars ? "star.fill" : "star")
                    .foregroundColor(.yellow)
            }
            
            if showChallengeStars {
                Image(systemName: stars >= 4 ? "star.fill" : "star")
                    .foregroundColor(.red)
                
            }
        }
    }
}
