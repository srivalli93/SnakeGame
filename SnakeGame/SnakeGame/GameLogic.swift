//
//  GameLogin.swift
//  SnakeGame
//
//  Created by Srivalli Kanchibotla on 9/6/25.
//

import Foundation

import Combine

class GameLogic: ObservableObject {
    @Published var snake: [Position] = []
    @Published var food: Food?
    @Published var direction: Direction = .right
    @Published var gameState: GameState = .ready
    @Published var score: Int = 0
    @Published var highScore: Int = 0
    
    let boardWidth: Int
    let boardHeight: Int
    private var gameTimer: Timer?
    private var gameSpeed: TimeInterval = 0.1
    
    init(boardWidth: Int = 20, boardHeight: Int = 30) {
           self.boardWidth = boardWidth
           self.boardHeight = boardHeight
           loadHighScore()
           setupNewGame()
       }
    
    func setupNewGame() {
          snake = [Position(x: boardWidth / 2, y: boardHeight / 2)]
          direction = .right
          score = 0
          gameState = .ready
          spawnFood()
      }
    
    func startGame() {
         gameState = .playing
         startGameTimer()
     }
    func pauseGame() {
          gameState = .paused
          stopGameTimer()
      }
      
      func resumeGame() {
          gameState = .playing
          startGameTimer()
      }
    
    func changeDirection(_ newDirection: Direction) {
         guard gameState == .playing else { return }
         
         // Prevent reversing into itself
         if newDirection != direction.opposite {
             direction = newDirection
         }
     }
    
    private func startGameTimer() {
        stopGameTimer()
        gameTimer = Timer.scheduledTimer(withTimeInterval: gameSpeed, repeats: true) { _ in
            self.moveSnake()
        }
    }
    
    private func stopGameTimer() {
        gameTimer?.invalidate()
        gameTimer = nil
    }
    
    private func moveSnake() {
            guard !snake.isEmpty else { return }
            
            let head = snake[0]
            let newHead = head + direction.vector
            
            // Check wall collision
            if newHead.x < 0 || newHead.x >= boardWidth ||
               newHead.y < 0 || newHead.y >= boardHeight {
                gameOver()
                return
            }
            
            // Check self collision
            if snake.contains(newHead) {
                gameOver()
                return
            }
            
            snake.insert(newHead, at: 0)
            
            // Check food collision
            if let food = food, newHead == food.position {
                score += food.points
                spawnFood()
                
                // Increase speed slightly
                            if gameSpeed > 0.1 {
                                gameSpeed -= 0.005
                                startGameTimer()
                            }
                        } else {
                            snake.removeLast()
                        }
                    }
                    
                    private func spawnFood() {
                        var newPosition: Position
                        repeat {
                            newPosition = Position(
                                x: Int.random(in: 0..<boardWidth),
                                y: Int.random(in: 0..<boardHeight)
                            )
                        } while snake.contains(newPosition)
                        
                        food = Food(position: newPosition)
                    }
    private func gameOver() {
        gameState = .gameOver
        stopGameTimer()
        
        if score > highScore {
            highScore = score
            saveHighScore()
        }
    }
    
    private func loadHighScore() {
        highScore = UserDefaults.standard.integer(forKey: "SnakeHighScore")
    }
    
    private func saveHighScore() {
        UserDefaults.standard.set(highScore, forKey: "SnakeHighScore")
    }
    
    
}
