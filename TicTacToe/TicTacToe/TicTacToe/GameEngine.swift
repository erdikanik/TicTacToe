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
}

protocol GameEnginePrivateInterface {

    var ticTacToeMatrix: [[TicTacToeType]] { get set }
}

final class GameEngine: GameEngineInterface, GameEnginePrivateInterface {

    var ticTacToeMatrix: [[TicTacToeType]] =
        [
            [.empty, .empty, .empty],
            [.empty, .empty, .empty],
            [.empty, .empty, .empty]
        ]

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

        return .gameContinue
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
}
