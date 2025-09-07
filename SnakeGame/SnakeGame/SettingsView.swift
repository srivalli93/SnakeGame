//
//  SettingsView.swift
//  SnakeGame
//
//  Created by Srivalli Kanchibotla on 9/6/25.
//

import SwiftUI

struct SettingsView: View {
    @State private var gameSpeed: Double = 0.3
    @State private var soundEnabled: Bool = true
    @State private var vibrationEnabled: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("Settings")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.green)
            
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading) {
                    Text("Game Speed")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    HStack {
                        Text("Slow")
                            .foregroundColor(.gray)
                        Slider(value: $gameSpeed, in: 0.1...0.5)
                            .accentColor(.green)
                        Text("Fast")
                            .foregroundColor(.gray)
                    }
                }
                
                Toggle("Sound Effects", isOn: $soundEnabled)
                    .foregroundColor(.white)
                    .toggleStyle(SwitchToggleStyle(tint: .green))
                
                Toggle("Vibration", isOn: $vibrationEnabled)
                    .foregroundColor(.white)
                    .toggleStyle(SwitchToggleStyle(tint: .green))
            }
            
            Spacer()
        }
        .padding()
        .background(Color.black.ignoresSafeArea())
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SettingsView()
}
