//
//  RidiculousCaptcha.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import SwiftUI

struct RidiculousCaptchaPlus: View {
    let onComplete: (Int) -> Void
    private let gridSize = 10
    @State private var selectedBoxes: Set<Int> = []
    @State private var timeElapsed = 0
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("Select all the boxes with a cat")
                .font(.title)
                .padding()
            
            ZStack {
                Image("cat")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: gridSize) {
                    ForEach(0..<gridSize * gridSize, id: \.self) { index in
                        Button(action: { toggleBox(index) }) {
                            Rectangle()
                                .fill(selectedBoxes.contains(index) ?
                                    Color.blue.opacity(0.5) : Color.clear)
                                .border(Color.gray)
                        }
                    }
                })
            }
            .frame(width: 300, height: 300)
        }
        .onReceive(timer) { _ in timeElapsed += 1 }
        .onChange(of: selectedBoxes) { _ in
            if selectedBoxes.count >= (gridSize * gridSize) / 3 {
                timer.upstream.connect().cancel()
                onComplete(timeElapsed)
            }
        }
    }
    
    private func toggleBox(_ index: Int) {
        selectedBoxes.contains(index) ? selectedBoxes.remove(index) : selectedBoxes.insert(index)
    }
}
