//
//  SetAlarmLevel.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import SwiftUI

struct SetAlarmLevelPlus: View {
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
