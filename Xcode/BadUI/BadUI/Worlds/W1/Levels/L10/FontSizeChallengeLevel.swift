//
//  FontSizeChallengeLevel.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import SwiftUI

struct FontSizeChallengeLevel: View {
    let onComplete: (Int) -> Void
    @State private var timeElapsed = 0
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var fontSize: CGFloat = 10
    @State private var sliderRangeIndex = 0
    @State private var sliderValue: Double = 1
    @State private var errorMessage = ""
    
    private let ranges: [[Double]] = [
        [1, 10],
        [11, 20],
        [21, 30],
        [31, 40]
    ]
    
    private var currentRange: [Double] {
        ranges[sliderRangeIndex]
    }
    
    var body: some View {
        VStack {
            Text("Font Size Challenge")
                .font(.title)
                .padding()
            
            Text("Adjust the font size to 20 by manipulating the sliders below.")
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Example text in the eReader view. Adjust the font size to make it readable.")
                .font(.system(size: fontSize))
                .padding()
                .frame(height: 150)
            
            VStack {
                Text("Select Range for Font Size:")
                    .font(.headline)
                
                Picker("Range", selection: $sliderRangeIndex) {
                    ForEach(0..<ranges.count, id: \.self) { index in
                        Text("\(Int(ranges[index][0]))-\(Int(ranges[index][1]))")
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of: sliderRangeIndex) { _, newValue in
                    sliderValue = currentRange[0]
                    fontSize = CGFloat(currentRange[0])
                }
            }
            .padding()
            
            VStack {
                Text("Set Font Size:")
                    .font(.headline)
                
                Slider(
                    value: $sliderValue,
                    in: currentRange[0]...currentRange[1],
                    step: 1
                ) {
                    Text("Font Size")
                } onEditingChanged: { _ in
                    fontSize = CGFloat(sliderValue)
                }
                
                Text("\(Int(sliderValue))")
                    .font(.title2)
            }
            .padding()
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            
            Button("Check Font Size") {
                if sliderValue == 20 {
                    timer.upstream.connect().cancel()
                    onComplete(timeElapsed)
                } else {
                    errorMessage = "Font size is not correct! Try adjusting the sliders."
                }
            }
            .buttonStyle(PrimaryButtonStyle())
        }
        .onReceive(timer) { _ in timeElapsed += 1 }
        .padding()
        .onAppear {
            // Randomize initial range
            sliderRangeIndex = Int.random(in: 0..<ranges.count)
            sliderValue = currentRange[0]
            fontSize = CGFloat(currentRange[0])
        }
    }
}
