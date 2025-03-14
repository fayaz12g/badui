//
//  CrazyCalculatorLevel.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import SwiftUI

struct CrazyCalculatorLevelPlus: View {
    let onComplete: (Int) -> Void
    @State private var timeElapsed = 0
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var display = ""
    @State private var result = ""
    @State private var errorMessage = ""
    
    let buttons: [[String]] = [
        ["7", "8", "9", "÷"],
        ["4", "5", "6", "×"],
        ["1", "2", "3", "-"],
        ["0", "^", "C", "+"]
    ]
    
    var body: some View {
        VStack {
            Text("Crazy Calculator")
                .font(.title)
                .padding()
            
            Text("Calculate the result of 4+4 in numerical value")
                .multilineTextAlignment(.center)
                .padding()
            
            // Display
            TextField("Enter calculation", text: $display)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.system(size: 24))
                .padding()
                .disabled(true)
            
            // Result display
            Text(result.isEmpty ? " " : result)
                .font(.title)
                .frame(height: 40)
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            
            // Calculator buttons
            ForEach(buttons, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { button in
                        CalculatorButton(
                            title: button,
                            action: handleButtonPress
                        )
                    }
                }
            }
            
            Button("Calculate") {
                evaluateExpression()
            }
            .buttonStyle(PrimaryButtonStyle())
        }
        .onReceive(timer) { _ in timeElapsed += 1 }
        .padding()
    }
    
    private func handleButtonPress(_ button: String) {
        switch button {
        case "C":
            display = ""
            result = ""
            errorMessage = ""
        case "÷":
            display += "/"
        case "×":
            display += "*"
        default:
            display += button
        }
    }
    
    private func evaluateExpression() {
        guard !display.isEmpty else { return }
        
        do {
            let expression = display
                .replacingOccurrences(of: "^", with: "**")
                .replacingOccurrences(of: " ", with: "")
            
            let mathExpression = NSExpression(format: expression)
            guard let value = mathExpression.expressionValue(with: nil, context: nil) as? Double else {
                throw CalculatorError.invalidExpression
            }
            
            if value == 8 {
                timer.upstream.connect().cancel()
                onComplete(timeElapsed)
            }
            
            result = numberToWord(value)
        } catch {
            errorMessage = "Error in calculation. Please enter a valid expression."
        }
    }
    
    private func numberToWord(_ num: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        return formatter.string(from: NSNumber(value: num)) ?? String(num)
    }
}

