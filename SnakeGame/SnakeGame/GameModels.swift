//
//  GameModels.swift
//  SnakeGame
//
//  Created by Srivalli Kanchibotla on 9/6/25.
//

import Foundation

struct Position: Equatable {
    let x: Int
    let y: Int
    
    static func + (lhs: Position, rhs: Position) -> Position {
        Position(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}

enum Direction: CaseIterable {
    case up, down, left, right
    
    var vector: Position {
        switch self {
        case .up: return Position(x: 0, y: -1)
        case .down: return Position(x: 0, y: 1)
        case .left: return Position(x: -1, y: 0)
        case .right: return Position(x: 1, y: 0)
        }
    }
    
    var opposite: Direction {
        switch self {
        case .up: return .down
        case .down: return .up
        case .left: return .right
        case .right: return .left
        }
    }
}

enum GameState {
    case ready, playing, paused, gameOver
}

struct Food {
    let position: Position
    let points: Int
    
    init(position: Position, points: Int = 10) {
        self.position = position
        self.points = points
    }
}
