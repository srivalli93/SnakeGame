//
//  GameView.swift
//  SnakeGame
//
//  Created by Srivalli Kanchibotla on 9/6/25.
//

import SwiftUI

struct GameView: View {
    @StateObject private var game = GameLogic()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // Score and controls
                HStack {
                    VStack(alignment: .leading) {
                        Text("Score: \(game.score)")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("High: \(game.highScore)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    if game.gameState == .paused {
                        Button("Resume") {
                            game.resumeGame()
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    } else if game.gameState == .playing {
                        Button("Pause") {
                            game.pauseGame()
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                }
                .padding()
                
                // Game board
                ZStack {
                    Rectangle()
                        .fill(Color.black)
                        .border(Color.green, width: 2)
                    
                    GameBoardView(game: game)
                    
                    if game.gameState == .ready {
                        VStack {
                            Text("Ready to Play!")
                                .font(.title)
                                .foregroundColor(.white)
                            Button("Start") {
                                game.startGame()
                            }
                            .font(.title2)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                    } else if game.gameState == .gameOver {
                        VStack {
                            Text("Game Over!")
                                .font(.title)
                                .foregroundColor(.red)
                            Text("Score: \(game.score)")
                                .font(.title2)
                                .foregroundColor(.white)
                            HStack {
                                Button("Play Again") {
                                    game.setupNewGame()
                                }
                                .font(.title3)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                
                                Button("Menu") {
                                    presentationMode.wrappedValue.dismiss()
                                }
                                .font(.title3)
                                .padding()
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            }
                        }
                    }
                }
                .aspectRatio(CGFloat(game.boardWidth) / CGFloat(game.boardHeight), contentMode: .fit)
                
                // Direction controls
                VStack(spacing: 20) {
                    Button(action: { game.changeDirection(.up) }) {
                        Image(systemName: "arrow.up")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(Color.green.opacity(0.7))
                            .cornerRadius(30)
                    }
                    
                    HStack(spacing: 40) {
                        Button(action: { game.changeDirection(.left) }) {
                            Image(systemName: "arrow.left")
                                .font(.title)
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(Color.green.opacity(0.7))
                                .cornerRadius(30)
                        }
                        
                        Button(action: { game.changeDirection(.right) }) {
                            Image(systemName: "arrow.right")
                                .font(.title)
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(Color.green.opacity(0.7))
                                .cornerRadius(30)
                        }
                    }
                    
                    Button(action: { game.changeDirection(.down) }) {
                        Image(systemName: "arrow.down")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(Color.green.opacity(0.7))
                            .cornerRadius(30)
                    }
                }
                .padding()
            }
        }
        .background(Color.black.ignoresSafeArea())
        .navigationBarHidden(true)
    }
}

struct GameBoardView: View {
    @ObservedObject var game: GameLogic
    
    var body: some View {
        GeometryReader { geometry in
            let cellWidth = geometry.size.width / CGFloat(game.boardWidth)
            let cellHeight = geometry.size.height / CGFloat(game.boardHeight)
            
            ZStack {
                // Snake
                ForEach(0..<game.snake.count, id: \.self) { index in
                    let position = game.snake[index]
                    Rectangle()
                        .fill(index == 0 ? Color.green : Color.green.opacity(0.8))
                        .frame(width: cellWidth - 1, height: cellHeight - 1)
                        .position(
                            x: CGFloat(position.x) * cellWidth + cellWidth / 2,
                            y: CGFloat(position.y) * cellHeight + cellHeight / 2
                        )
                }
                
                // Food
                if let food = game.food {
                    Circle()
                        .fill(Color.red)
                        .frame(width: cellWidth - 2, height: cellHeight - 2)
                        .position(
                            x: CGFloat(food.position.x) * cellWidth + cellWidth / 2,
                            y: CGFloat(food.position.y) * cellHeight + cellHeight / 2
                        )
                }
            }
        }
    }
}

#Preview {
    GameView()
}
