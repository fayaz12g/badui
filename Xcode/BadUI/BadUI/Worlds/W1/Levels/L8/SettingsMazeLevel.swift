//
//  SettingsMazeLevel.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import SwiftUI

struct SettingsMazeLevel: View {
    let onComplete: () -> Void
    @State private var currentScreen: Screen = .main
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var settings = Settings()
    @State private var hasScrolledEula = false
    
    enum Screen {
        case main, privacy, eula, bluetooth, battery
    }
    
    var body: some View {
        NavigationView {
            Group {
                switch currentScreen {
                case .main:
                    mainSettings
                case .privacy:
                    privacySettings
                case .eula:
                    eulaSettings
                case .bluetooth:
                    bluetoothSettings
                case .battery:
                    batterySettings
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .alert("Error", isPresented: $showAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    private var mainSettings: some View {
        List {
            NavigationLink("Privacy & Security", destination: { privacySettings })
            NavigationLink("Bluetooth", destination: { bluetoothSettings })
            NavigationLink("Battery", destination: { batterySettings })
            NavigationLink("EULA", destination: { eulaSettings })
            
            Toggle("Airplane Mode", isOn: $settings.airplaneMode)
            Toggle("Notifications", isOn: $settings.notifications)
        }
        .navigationTitle("Settings")
    }
    
    private var privacySettings: some View {
        List {
            Toggle("Location Services", isOn: $settings.location)
        }
        .navigationTitle("Privacy")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            backButton
        }
    }
    
    private var bluetoothSettings: some View {
        List {
            Toggle("Bluetooth", isOn: $settings.bluetooth)
            
            if settings.bluetooth {
                Button("Speaker") {
                    if settings.bluetooth {
                        onComplete()
                    } else {
                        showAlert(message: "Enable Bluetooth first")
                    }
                }
            }
        }
        .navigationTitle("Bluetooth")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            backButton
        }
    }
    
    private var batterySettings: some View {
        List {
            Toggle("Battery Optimization", isOn: $settings.batteryOptimization)
        }
        .navigationTitle("Battery")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            backButton
        }
    }
    
    private var eulaSettings: some View {
        ScrollView {
            VStack {
                Text(eulaText)
                    .padding()
                
                Toggle("I have read the EULA", isOn: $hasScrolledEula)
                
                Button("Accept") {
                    if hasScrolledEula {
                        settings.eulaAccepted = true
                        currentScreen = .main
                    } else {
                        showAlert(message: "Please read the entire EULA first")
                    }
                }
                .buttonStyle(PrimaryButtonStyle())
            }
        }
        .navigationTitle("EULA")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            backButton
        }
    }
    
    private var backButton: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button("Back") {
                currentScreen = .main
            }
        }
    }
    
    private func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
    
    private struct Settings {
        var airplaneMode = false
        var notifications = true
        var location = false
        var bluetooth = false
        var batteryOptimization = true
        var eulaAccepted = false
    }
    
    private let eulaText = """
    End User License Agreement (EULA)

    1. Grant of License
    Subject to the terms of this EULA, we grant you a limited, non-exclusive license to use the App...

    [Full EULA text here...]
    """
}
