//
//  HighScore.swift
//  SnakeGame
//
//  Created by Srivalli Kanchibotla on 9/6/25.
//

import SwiftUI

struct HighScoreView: View {
    @State private var highScore: Int = 0
    
    var body: some View {
        VStack(spacing: 30) {
            Text("High Scores")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.green)
            
            VStack(spacing: 20) {
                HStack {
                    Text("🏆")
                        .font(.title)
                    Text("Best Score:")
                        .font(.title2)
                        .foregroundColor(.white)
                    Spacer()
                    Text("\(highScore)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                
                Button("Reset High Score") {
                    UserDefaults.standard.set(0, forKey: "SnakeHighScore")
                    highScore = 0
                }
                .font(.title3)
                .foregroundColor(.red)
                .padding()
                .background(Color.red.opacity(0.2))
                .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.black.ignoresSafeArea())
        .navigationTitle("High Scores")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            highScore = UserDefaults.standard.integer(forKey: "SnakeHighScore")
        }
    }
}

#Preview {
    HighScoreView()
}
