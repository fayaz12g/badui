//
//  RidiculousCaptcha.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import SwiftUI

struct RidiculousCaptcha: View {
    let onComplete: () -> Void
    private let gridSize = 10
    @State private var selectedBoxes: Set<Int> = []
    
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
        .onChange(of: selectedBoxes) { _ in
            if selectedBoxes.count >= (gridSize * gridSize) / 3 {
                onComplete()
            }
        }
    }
    
    private func toggleBox(_ index: Int) {
        if selectedBoxes.contains(index) {
            selectedBoxes.remove(index)
        } else {
            selectedBoxes.insert(index)
        }
    }
}
