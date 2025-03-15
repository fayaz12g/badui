//
//  OnScreenKeyboardLevel.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import SwiftUI

struct OnScreenKeyboardLevel: View {
    @EnvironmentObject var gameManager: GameManager
    @State private var timeElapsed = 0
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var username = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var isShiftActive = false
    @FocusState private var focusedField: Field?
    
    private let correctUsername = "Fayaz"
    private let correctPassword = "fayazisCOOL"
    private let letters = (65...90).map { String(UnicodeScalar($0)) }
    
    enum Field {
        case username, password
    }

    var body: some View {
        VStack {
            VStack {
                TextField("Username", text: $username)
                    .disabled(true)
                    .focused($focusedField, equals: .username)
                
                SecureField("Password", text: $password)
                    .disabled(true)
                    .focused($focusedField, equals: .password)
                
                // Keyboard Grid
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 6)) {
                    ForEach(letters, id: \.self) { letter in
                        KeyboardKey(letter: isShiftActive ? letter : letter.lowercased()) {
                            handleKeyPress(letter)
                        }
                    }
                }
                
                // Control Row
                HStack {
                    KeyboardKey(letter: "Shift") {
                        isShiftActive.toggle()
                    }
                    KeyboardKey(letter: "⌫") {
                        handleBackspace()
                    }
                }
                
                // Login Button
                Button("Login") {
                    handleLogin()
                }
                .buttonStyle(PrimaryButtonStyle())
                
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            .padding()
        }
        .onReceive(timer) { _ in timeElapsed += 1 }
        .onAppear {
            focusedField = .username
        }
    }
    
    private func handleKeyPress(_ letter: String) {
        let char = isShiftActive ? letter : letter.lowercased()
        if focusedField == .username {
            username += char
        } else {
            password += char
        }
        isShiftActive = false
    }
    
    private func handleBackspace() {
        if focusedField == .username {
            username = String(username.dropLast())
        } else {
            password = String(password.dropLast())
        }
    }
    
    private func handleLogin() {
        if username == correctUsername && password == correctPassword {
            timer.upstream.connect().cancel()
            gameManager.handleLevelCompletion(timeElapsed: timeElapsed)
        } else {
            errorMessage = "Invalid credentials"
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
