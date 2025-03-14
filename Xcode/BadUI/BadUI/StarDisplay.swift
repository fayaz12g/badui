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
    
    var body: some View {
        HStack {
            if mode == "c" {
                // Challenge mode - single red star
                Image(systemName: "star.fill")
                    .foregroundColor(stars >= 4 ? .red : .gray)
                    .overlay(
                        Text("C")
                            .font(.caption2)
                            .bold()
                            .offset(y: 2)
                    )
            } else {
                // Normal mode - up to 3 stars
                ForEach(0..<3) { index in
                    Image(systemName: index < stars ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                }
            }
        }
    }
}
