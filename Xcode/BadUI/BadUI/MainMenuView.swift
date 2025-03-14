//
//  MainMenuView.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import SwiftUI

struct MainMenuView: View {
    let onStart: () -> Void
    @State private var isVisible = true
    
    var body: some View {
        ZStack {
            Color.red.ignoresSafeArea()
            
            VStack {
                Image("baduilogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                
                Text("Click Anywhere to Begin")
                    .font(.title)
                    .foregroundColor(.yellow)
                    .opacity(isVisible ? 1 : 0)
                    .animation(.easeInOut(duration: 0.8).repeatForever(), value: isVisible)
            }
        }
        .onTapGesture(perform: onStart)
        .onAppear {
            isVisible.toggle()
        }
    }
}
