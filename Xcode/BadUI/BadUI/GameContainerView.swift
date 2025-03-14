//
//  GameContainerView.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//


import SwiftUI


struct GameContainerView: View {
    @EnvironmentObject var gameManager: GameManager
    @State private var timeElapsed = 0
    @State private var timer: Timer? = nil
    
    var body: some View {
        VStack {
            GameHeaderView()
            
            if let level = gameManager.currentLevel {
                // Render level component here
                // You'll need to create SwiftUI views for each level type
                LevelView(level: level)
            }
            
            Spacer()
        }
        .onAppear(perform: startTimer)
        .onDisappear(perform: stopTimer)
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            timeElapsed += 1
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
