//
//  ClickTrainingLevel2.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import SwiftUI

struct ClickTrainingLevel2Plus: View {
    let onComplete: (Int) -> Void
    @State private var clicks = 0
    @State private var progress: CGFloat = 0
    @State private var timeElapsed = 0
    private let requiredClicks = 5
    private let fallbackSpeed: CGFloat = 4
    private let clickIncrement: CGFloat = 20
    private let progressTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    private let gameTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("Click Training 2")
                .font(.title)
                .padding()
            
            Text("Click the button enough times before the progress resets!")
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Progress: \(Int(min(progress, 100)))%")
                .padding()
            
            Text("Time: \(timeElapsed)s")
                .font(.headline)
            
            Button(action: handleClick) {
                Text("Click Me!")
                    .frame(width: 200, height: 50)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [.blue, .purple]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .mask(
                            GeometryReader { geo in
                                Rectangle()
                                    .frame(width: geo.size.width * (progress/100))
                            }
                        )
                    )
                    .overlay(
                        Text("Click Me!")
                            .foregroundColor(.white)
                    )
                    .cornerRadius(10)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding()
        .onReceive(progressTimer) { _ in
            withAnimation {
                progress = max(progress - fallbackSpeed, 0)
            }
        }
        .onReceive(gameTimer) { _ in
            if progress < 100 {
                timeElapsed += 1
            }
        }
        .onChange(of: progress) { _, newValue in
            if newValue >= 100 {
                progressTimer.upstream.connect().cancel()
                gameTimer.upstream.connect().cancel()
                onComplete(timeElapsed)
            }
        }
    }
    
    private func handleClick() {
        clicks += 1
        withAnimation {
            progress = min(progress + clickIncrement, 100)
        }
    }
}
