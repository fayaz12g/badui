//
//  OnScreenKeyboardLevel.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import SwiftUI

struct OnScreenKeyboardLevel: View {
    let onComplete: () -> Void
    @State private var username = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var isShiftActive = false
    private let correctUsername = "Fayaz"
    private let correctPassword = "fayazisCOOL"
    
    private let letters = (65...90).map { String(UnicodeScalar($0)) }
    
    var body: some View {
        VStack {
            VStack {
                TextField("Username", text: $username)
                    .disabled(true)
                SecureField("Password", text: $password)
                    .disabled(true)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 6) {
                    ForEach(letters, id: \.self) { letter in
                        KeyboardKey(letter: isShiftActive ? letter : letter.lowercased()) {
                            handleKeyPress(letter)
                        }
                    }
                }
                
                HStack {
                    KeyboardKey(letter: "Shift") {
                        isShiftActive.toggle()
                    }
                    KeyboardKey(letter: "⌫") {
                        handleBackspace()
                    }
                }
                
                Button("Login") {
                    if username == correctUsername && password == correctPassword {
                        onComplete()
                    } else {
                        errorMessage = "Invalid credentials"
                    }
                }
                .buttonStyle(PrimaryButtonStyle())
                
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            .padding()
        }
    }
    
    private func handleKeyPress(_ letter: String) {
        let char = isShiftActive ? letter : letter.lowercased()
        if username.isFocused {
            username += char
        } else {
            password += char
        }
        isShiftActive = false
    }
    
    private func handleBackspace() {
        if username.isFocused {
            username = String(username.dropLast())
        } else {
            password = String(password.dropLast())
        }
    }
}

struct KeyboardKey: View {
    let letter: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(letter)
                .frame(width: 50, height: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}
