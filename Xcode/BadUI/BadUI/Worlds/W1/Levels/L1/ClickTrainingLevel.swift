//
//  ClickTrainingLevel.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import SwiftUI

struct ClickTrainingLevel: View {
    @EnvironmentObject var gameManager: GameManager
    @State private var clicks = 0
    @State private var timeElapsed = 0
    private let requiredClicks = 5
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("Click Training")
                .font(.title)
                .padding()
            
            Text("Even a child could do this one. Click the button \(requiredClicks) times to complete the level!")
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Progress: \(clicks)/\(requiredClicks)")
                .font(.title2)
                .padding()
            
            Text("Time: \(timeElapsed)s")
                .font(.headline)
                .padding()
            
            Button(action: handleClick) {
                Text("Click Me!")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .scaleEffect(clicks == requiredClicks ? 1.2 : 1)
                    .animation(.spring(), value: clicks)
            }
        }
        .padding()
        .onReceive(timer) { _ in
            if clicks < requiredClicks {
                timeElapsed += 1
            }
        }
    }
    
    private func handleClick() {
        guard clicks < requiredClicks else { return }
        
        clicks += 1
        if clicks >= requiredClicks {
            // Stop the timer
            timer.upstream.connect().cancel()
            // Trigger completion with time elapsed
            gameManager.handleLevelCompletion(timeElapsed: timeElapsed)
        }
    }
}
