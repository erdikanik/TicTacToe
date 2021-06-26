//
//  TicTacToeViewModel.swift
//  TicTacToe
//
//  Created by Erdi on 26.06.2021.
//

import Foundation

protocol TicTacToeViewModelInterface {

    /// State change handler of the tic tac toe view model
    var stateChangeHandler: ((TicTacToeViewModel.State) -> Void)? { get set }

    /// Call when it is needed to restart the game
    func needsToRestartTheGame()

    /// Put TicTacToe marker to board
    /// - Parameter indexPathRow: Array index
    func markGameBoard(with indexPathRow: Int)
}

protocol TicTacToeViewModelPrivateInterface {

    var gameEngine: GameEngineInterface { get set }
}

final class TicTacToeViewModel: TicTacToeViewModelPrivateInterface {

    private enum Constant {

        static let gridSize = 3
    }

    enum State {

        case gameStarted([String], String)
        case gameStateChanged([String], String)
    }

    var stateChangeHandler: ((State) -> Void)?

    var gameEngine: GameEngineInterface = GameEngine()
}

// MARK - TicTacToeViewModelInterface

extension TicTacToeViewModel: TicTacToeViewModelInterface {

    func needsToRestartTheGame() {
        stateChangeHandler?(
            .gameStarted(
                gameEngine.gameBoardValues.map { localizedTicTacTocType(type: $0) },
                localizedPlayerState(state: gameEngine.playerState)
            )
        )
    }

    func markGameBoard(with indexPathRow: Int) {
        let state = gameEngine.markAndChangeGameState(row: indexPathRow / Constant.gridSize,
                                                      column: indexPathRow % Constant.gridSize)
        stateChangeHandler?(
            .gameStateChanged(
                gameEngine.gameBoardValues.map { localizedTicTacTocType(type: $0) }, localizedPlayerState(state: state)
            )
        )
    }
}

// MARK - Helper methods

private extension TicTacToeViewModel {

    func localizedPlayerState(state: GameState) -> String {
        switch state {
        case .x:
            return NSLocalizedString("Player X", comment: "")
        case .o:
            return NSLocalizedString("Player O", comment: "")
        }
    }

    func localizedTicTacTocType(type: TicTacToeType) -> String {
        switch type {
        case .x:
            return NSLocalizedString("X", comment: "")
        case .o:
            return NSLocalizedString("O", comment: "")
        case .empty:
            return NSLocalizedString("", comment: "")
        }
    }
}
