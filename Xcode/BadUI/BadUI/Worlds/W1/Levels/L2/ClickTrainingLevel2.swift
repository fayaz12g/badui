//
//  ClickTrainingLevel2.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import SwiftUI

struct ClickTrainingLevel2: View {
    let onComplete: () -> Void
    @State private var clicks = 0
    @State private var progress: CGFloat = 0
    private let requiredClicks = 5
    private let fallbackSpeed: CGFloat = 4
    private let clickIncrement: CGFloat = 20
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
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
        .onReceive(timer) { _ in
            withAnimation {
                progress = max(progress - fallbackSpeed, 0)
            }
        }
        .onChange(of: progress) { newValue in
            if newValue >= 100 {
                onComplete()
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
