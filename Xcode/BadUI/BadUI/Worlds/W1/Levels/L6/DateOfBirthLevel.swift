//
//  DateOfBirthLevel.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import SwiftUI

struct DateOfBirthLevel: View {
    let onComplete: (Int) -> Void
    @State private var selectedDay = ""
    @State private var selectedMonth = ""
    @State private var selectedYear = ""
    @State private var shuffledMonths: [String] = []
    @State private var shuffledDays: [String] = []
    @State private var shuffledYears: [String] = []
    @State private var timeElapsed = 0
    private let targetDay = "22"
    private let targetMonth = "June"
    private let targetYear = "2002"
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("Fill in your date of birth: June 22, 2002")
                .font(.title)
                .padding()
            
            Text("Time: \(timeElapsed)s")
                .font(.headline)
            
            Picker("Month", selection: $selectedMonth) {
                Text("Select Month").tag("")
                ForEach(shuffledMonths, id: \.self) { month in
                    Text(month)
                }
            }
            .pickerStyle(.menu)
            .padding()
            
            Picker("Day", selection: $selectedDay) {
                Text("Select Day").tag("")
                ForEach(shuffledDays, id: \.self) { day in
                    Text(day)
                }
            }
            .pickerStyle(.menu)
            .padding()
            
            Picker("Year", selection: $selectedYear) {
                Text("Select Year").tag("")
                ForEach(shuffledYears, id: \.self) { year in
                    Text(year)
                }
            }
            .pickerStyle(.menu)
            .padding()
            
            Button("Submit") {
                if selectedDay == targetDay &&
                   selectedMonth == targetMonth &&
                   selectedYear == targetYear {
                    timer.upstream.connect().cancel()
                    onComplete(timeElapsed)
                }
            }
            .buttonStyle(PrimaryButtonStyle())
        }
        .padding()
        .onAppear {
            let months = ["January", "February", "March", "April", "May", "June",
                          "July", "August", "September", "October", "November", "December"]
            let days = (1...31).map { String($0) }
            let years = (1980...2010).map { String($0) }
            
            shuffledMonths = months.shuffled()
            shuffledDays = days.shuffled()
            shuffledYears = years.shuffled()
        }
        .onReceive(timer) { _ in
            timeElapsed += 1
        }
    }
}
