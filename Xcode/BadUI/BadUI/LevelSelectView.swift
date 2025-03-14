//
//  LevelSelectView.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import SwiftUI

struct LevelSelectView: View {
    @EnvironmentObject var gameManager: GameManager
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        ScrollView {
            VStack {
                Text(gameManager.currentWorld?.name ?? "Select Level")
                    .font(.largeTitle)
                    .padding()
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))]) {
                    if let levels = gameManager.currentWorld?.levels {
                        ForEach(levels) { level in
                            LevelCard(level: level)
                        }
                    }
                }
                .padding()
            }
        }
    }
}
