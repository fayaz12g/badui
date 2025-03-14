//
//  MoneySliderLevel.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import SwiftUI

struct MoneySliderLevelPlus: View {
    let onComplete: (Int) -> Void
    @State private var sliderValue: Double = 0
    @State private var timeElapsed = 0
    private let targetAmount: Double = 74.23
    private let threshold: Double = 1
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("Send Money")
                .font(.title)
                .padding()
            
            Text("Send the client $74.23. Hint: There's a $1 threshold.")
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Current Amount: $\(sliderValue, specifier: "%.2f")")
                .padding()
            
            Text("Time: \(timeElapsed)s")
                .font(.headline)
            
            GeometryReader { geo in
                ZStack {
                    Path { path in
                        path.move(to: CGPoint(x: 10, y: geo.size.height/2))
                        path.addCurve(
                            to: CGPoint(x: geo.size.width - 10, y: geo.size.height/2),
                            control1: CGPoint(x: geo.size.width/4, y: -20),
                            control2: CGPoint(x: geo.size.width * 3/4, y: geo.size.height + 20)
                        )
                    }
                    .stroke(Color.blue, lineWidth: 4)
                    
                    Slider(value: $sliderValue, in: 0...100, step: 0.01)
                        .accentColor(.clear)
                        .background(
                            ThumbView()
                                .offset(x: (geo.size.width - 30) * CGFloat(sliderValue/100) - 15)
                        )
                }
            }
            .frame(height: 80)
            
            Button("Send $\(sliderValue, specifier: "%.2f")") {
                if abs(sliderValue - targetAmount) <= threshold {
                    timer.upstream.connect().cancel()
                    onComplete(timeElapsed)
                }
            }
            .buttonStyle(PrimaryButtonStyle())
        }
        .padding()
        .onReceive(timer) { _ in
            timeElapsed += 1
        }
    }
}

struct ThumbView: View {
    var body: some View {
        Circle()
            .fill(Color.blue)
            .frame(width: 30, height: 30)
            .shadow(radius: 3)
    }
}
