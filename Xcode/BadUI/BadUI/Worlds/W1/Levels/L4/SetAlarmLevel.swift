//
//  SetAlarmLevel.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import SwiftUI

struct SetAlarmLevel: View {
    let onComplete: (Int) -> Void
    @State private var hours = 1
    @State private var minutes = 0
    @State private var ampm = "AM"
    @State private var isHoursRunning = false
    @State private var isMinutesRunning = false
    @State private var isAmpmRunning = false
    @State private var timeElapsed = 0
    private let targetHours = 7
    private let targetMinutes = 30
    private let targetAmpm = "AM"
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("Set Alarm")
                .font(.title)
                .padding()
            
            Text("Set the alarm for 7:30 AM")
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Time: \(timeElapsed)s")
                .font(.headline)
            
            HStack(spacing: 20) {
                            NumericTimeComponent(
                                value: $hours,
                                label: "Hours",
                                isRunning: $isHoursRunning,
                                range: 1...12
                            )
                            
                            NumericTimeComponent(
                                value: $minutes,
                                label: "Minutes",
                                isRunning: $isMinutesRunning,
                                range: 0...59,
                                format: "%02d"
                            )
                            
                            AMPMComponent(
                                value: $ampm,
                                isRunning: $isAmpmRunning
                            )
                        }
            .padding()
            
            Button("Set Alarm") {
                if hours == targetHours && minutes == targetMinutes && ampm == targetAmpm {
                    timer.upstream.connect().cancel()
                    onComplete(timeElapsed)
                }
            }
            .buttonStyle(PrimaryButtonStyle())
        }
        .padding()
        .onReceive(timer) { _ in
            timeElapsed += 1
        }
    }
}

// Separate components for numeric and AM/PM controls
struct NumericTimeComponent: View {
    @Binding var value: Int
    let label: String
    @Binding var isRunning: Bool
    let range: ClosedRange<Int>
    var format: String = "%d"
    
    var body: some View {
        VStack {
            Text(String(format: format, value))
                .font(.title)
            
            Button(isRunning ? "Stop" : "Start") {
                isRunning.toggle()
            }
            .buttonStyle(SecondaryButtonStyle())
        }
        .onChange(of: isRunning) { _, running in
            guard running else { return }
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
                guard isRunning else {
                    timer.invalidate()
                    return
                }
                value = (value % (range.upperBound - range.lowerBound + 1)) + range.lowerBound
            }
        }
    }
}

struct AMPMComponent: View {
    @Binding var value: String
    @Binding var isRunning: Bool
    let options = ["AM", "PM"]
    
    var body: some View {
        VStack {
            Text(value)
                .font(.title)
            
            Button(isRunning ? "Stop" : "Start") {
                isRunning.toggle()
            }
            .buttonStyle(SecondaryButtonStyle())
        }
        .onChange(of: isRunning) { _, running in
            guard running else { return }
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
                guard isRunning else {
                    timer.invalidate()
                    return
                }
                value = options.randomElement() ?? "AM"
            }
        }
    }
}
