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
    let challengeStars: Int
    let showChallengeStars: Bool
    
    // Default parameters for backward compatibility
    init(stars: Int, mode: String, challengeStars: Int = 0, showChallengeStars: Bool = false) {
        self.stars = stars
        self.mode = mode
        self.challengeStars = challengeStars
        self.showChallengeStars = showChallengeStars
    }
    
    var body: some View {
        HStack(spacing: 4) {
            // Regular stars (yellow)
            ForEach(0..<3) { index in
                Image(systemName: index < stars ? "star.fill" : "star")
                    .foregroundColor(.yellow)
            }
            
            // Challenge star (red) - only show if we should display challenge stars
            if showChallengeStars {
                Image(systemName: challengeStars > 0 ? "star.fill" : "star")
                    .foregroundColor(.red)
            }
        }
    }
}
