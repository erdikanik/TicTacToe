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

    var ticTacToeMatrix: [[TicTacToeType]] = []

    func gameResult() -> GameResult {

        guard !ticTacToeMatrix.isEmpty else {
            return .gameContinue
        }

        return .gameContinue
    }
}
