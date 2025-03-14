//
//  ThemeManager.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import SwiftUI

class ThemeManager: ObservableObject {
    @Published var isDarkMode: Bool = false
    @Published var accentColor: Color = .red
}
