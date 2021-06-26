//
//  GameEngine.swift
//  TicTacToe
//
//  Created by Erdi on 26.06.2021.
//

import Foundation


/// Game engine interface for communicating with game engine
protocol GameEngineInterface {

    /// Game result
    func gameResult() -> GameResult

    /// Marks and return next state
    func markAndChangeGameState(row: Int, column: Int) -> GameState

    /// Restart game and empty stored variables
    func restartTheGame()

    /// Current values of game board
    var gameBoardValues: [TicTacToeType] { get }
}

protocol GameEnginePrivateInterface {

    var ticTacToeMatrix: [[TicTacToeType]] { get set }
    var gameState: GameState { get set }
}

enum GameState {
    case x
    case o

    func toTicTacToeType() -> TicTacToeType {
        switch self {
        case .x:
            return .x
        case .o:
            return .o
        }
    }
}

final class GameEngine: GameEngineInterface, GameEnginePrivateInterface {

    var gameState: GameState = .x

    var ticTacToeMatrix: [[TicTacToeType]] =
        [
            [.empty, .empty, .empty],
            [.empty, .empty, .empty],
            [.empty, .empty, .empty]
        ]

    var gameBoardValues: [TicTacToeType] {
        ticTacToeMatrix.flatMap { $0 }
    }

    func restartTheGame() {
        gameState = .x
        ticTacToeMatrix = ticTacToeMatrix.map { _ in [.empty, .empty, .empty ] }
    }

    func markAndChangeGameState(row: Int, column: Int) -> GameState {
        guard ticTacToeMatrix[row][column] == .empty else { return gameState }

        ticTacToeMatrix[row][column] = gameState.toTicTacToeType()
        toggleGameState()
        return gameState
    }
    
    func gameResult() -> GameResult {

        guard !ticTacToeMatrix.isEmpty else {
            return .gameContinue
        }

        let horizontalResult = horizontallyCheckTheMatrix()
        if horizontalResult != .none {
            return horizontalResult.gameResult()
        }

        let verticalResult = verticallyCheckTheMatrix()
        if verticalResult != .none {
            return verticalResult.gameResult()
        }

        let crossResult = crossCheckTheMatrix()
        if crossResult != .none {
            return crossResult.gameResult()
        }

        return isTheMatrixFilled() ? .draw : .gameContinue
    }
}

// MARK - Helper methods

private extension GameEngine {

    enum WinnerType {
        case x
        case o
        case none

        func gameResult() -> GameResult {
            switch self {
            case .x:
                return .winX
            case .o:
                return .winO
            case .none:
                return .gameContinue
            }
        }

        static func winnerType(for ticTacToeType: TicTacToeType) -> WinnerType {
            switch ticTacToeType {
            case .x:
                return .x
            case .o:
                return .o
            case .empty:
                return .none
            }
        }
    }

    /// Check the matrix horizontally
    /// - Returns: Winner type
    func horizontallyCheckTheMatrix() -> WinnerType {
        for row in ticTacToeMatrix {
            let previous = row[0]
            var result = WinnerType.winnerType(for: previous)

            if previous == .empty {
                continue
            }

            for element in row {
                if element != previous {
                    result = .none
                    break
                }
            }

            if result != .none {
                return result
            }
        }

        return .none
    }

    func verticallyCheckTheMatrix() -> WinnerType {
        for x in 0..<ticTacToeMatrix.count {
            let previous = ticTacToeMatrix[0][x]
            var result = WinnerType.winnerType(for: previous)

            for y in 1..<ticTacToeMatrix.count {
                if ticTacToeMatrix[y][x] != previous {
                    result = .none
                    break
                }
            }

            if result != .none {
                return result
            }
        }

        return .none
    }

    func crossCheckTheMatrix() -> WinnerType {

        if ticTacToeMatrix[0][0] != .empty &&
            ((ticTacToeMatrix[0][0] == ticTacToeMatrix[1][1])
                && (ticTacToeMatrix[0][0] == ticTacToeMatrix[2][2])) {
            return WinnerType.winnerType(for: ticTacToeMatrix[0][0])
        }

        if ticTacToeMatrix[0][2] != .empty &&
            ((ticTacToeMatrix[0][2] == ticTacToeMatrix[1][1])
                && (ticTacToeMatrix[0][2] == ticTacToeMatrix[2][0])) {
            return WinnerType.winnerType(for: ticTacToeMatrix[0][2])
        }

        return .none
    }

    func isTheMatrixFilled() -> Bool {
        return !ticTacToeMatrix.flatMap { $0 }.contains(where: { $0 == .empty })
    }

    func toggleGameState() {
        if gameState == .x {
            gameState = .o
        } else {
            gameState = .x
        }
    }
}
