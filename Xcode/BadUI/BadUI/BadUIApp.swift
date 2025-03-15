//
//  BadUIApp.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import SwiftUI

@main
struct BadUIApp: App {
    @StateObject var gameManager = GameManager()
    
    var body: some Scene {
        WindowGroup {
            GameView()
                .environmentObject(gameManager)
        }
    }
}
