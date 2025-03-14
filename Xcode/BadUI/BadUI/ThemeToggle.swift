//
//  ThemeToggle.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import SwiftUI

struct ThemeToggle: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    themeManager.isDarkMode.toggle()
                }) {
                    Image(systemName: themeManager.isDarkMode ? "sun.max.fill" : "moon.fill")
                        .padding()
                        .background(themeManager.isDarkMode ? Color.gray : Color.red)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                .padding()
            }
        }
    }
}
