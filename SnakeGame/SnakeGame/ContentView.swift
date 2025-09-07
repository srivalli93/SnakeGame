//
//  ContentView.swift
//  SnakeGame
//
//  Created by Srivalli Kanchibotla on 9/6/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("🐍 Snake Game")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                
                VStack(spacing: 20) {
                    NavigationLink(destination: GameView()) {
                        Text("Start Game")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(Color.green)
                            .cornerRadius(25)
                    }
                    
                    NavigationLink(destination: SettingsView()) {
                        Text("Settings")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.green)
                            .frame(width: 200, height: 50)
                            .background(Color.green.opacity(0.2))
                            .cornerRadius(25)
                    }
                    
                    NavigationLink(destination: HighScoreView()) {
                        Text("High Scores")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.green)
                            .frame(width: 200, height: 50)
                            .background(Color.green.opacity(0.2))
                            .cornerRadius(25)
                    }
                }
                
                Spacer()
            }
            .padding()
            .background(Color.black.ignoresSafeArea())
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    ContentView()
}
