//
//  SetAlarmLevel.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import SwiftUI

struct SetAlarmLevel: View {
    let onComplete: () -> Void
    @State private var hours = 1
    @State private var minutes = 0
    @State private var ampm = "AM"
    @State private var isHoursRunning = false
    @State private var isMinutesRunning = false
    @State private var isAmpmRunning = false
    
    private let targetHours = 7
    private let targetMinutes = 30
    private let targetAmpm = "AM"
    
    var body: some View {
        VStack {
            Text("Set Alarm")
                .font(.title)
                .padding()
            
            Text("Set the alarm for 7:30 AM")
                .multilineTextAlignment(.center)
                .padding()
            
            HStack(spacing: 20) {
                TimeComponent(
                    value: hours,
                    label: "Hours",
                    isRunning: $isHoursRunning,
                    range: 1...12
                )
                
                TimeComponent(
                    value: minutes,
                    label: "Minutes",
                    isRunning: $isMinutesRunning,
                    range: 0...59,
                    format: "%02d"
                )
                
                TimeComponent(
                    value: ampm == "AM" ? 0 : 1,
                    label: "AM/PM",
                    isRunning: $isAmpmRunning,
                    range: 0...1,
                    display: { $0 == 0 ? "AM" : "PM" }
                )
            }
            .padding()
            
            Button("Set Alarm") {
                if hours == targetHours && minutes == targetMinutes && ampm == targetAmpm {
                    onComplete()
                } else {
                    // Show error
                }
            }
            .buttonStyle(PrimaryButtonStyle())
        }
    }
}

struct TimeComponent<T: Hashable>: View {
    @Binding var value: T
    let label: String
    @Binding var isRunning: Bool
    let range: ClosedRange<T>
    var format: String = "%d"
    var display: (T) -> String = { String(format: "%d", $0 as! CVarArg) }
    
    var body: some View {
        VStack {
            Text(display(value))
                .font(.title)
            
            Button(isRunning ? "Stop" : "Start") {
                isRunning.toggle()
            }
            .buttonStyle(SecondaryButtonStyle())
        }
        .onChange(of: isRunning) { running in
            guard running else { return }
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
                guard isRunning else {
                    timer.invalidate()
                    return
                }
                // Update value logic
            }
        }
    }
}
