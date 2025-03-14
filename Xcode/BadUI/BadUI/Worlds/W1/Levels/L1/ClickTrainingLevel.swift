//
//  ClickTrainingLevel.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import SwiftUI

struct ClickTrainingLevel: View {
    let onComplete: () -> Void
    @State private var clicks = 0
    private let requiredClicks = 5
    
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
    }
    
    private func handleClick() {
        clicks += 1
        if clicks >= requiredClicks {
            onComplete()
        }
    }
}
