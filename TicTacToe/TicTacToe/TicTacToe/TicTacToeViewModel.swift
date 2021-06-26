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
}

protocol TicTacToeViewModelPrivateInterface {

    var gameEngine: GameEngineInterface { get set }
}

final class TicTacToeViewModel: TicTacToeViewModelPrivateInterface {

    enum State {

        case gameStarted([TicTacToeType], String)
    }

    var stateChangeHandler: ((State) -> Void)?

    var gameEngine: GameEngineInterface = GameEngine()
}

// MARK - TicTacToeViewModelInterface

extension TicTacToeViewModel: TicTacToeViewModelInterface {

    func needsToRestartTheGame() {
        stateChangeHandler?(.gameStarted(gameEngine.gameBoardValues,
                                        localizedPlayerState(state: gameEngine.playerState)))
    }
}

// MARK - Helper methods

private extension TicTacToeViewModel {

    func localizedPlayerState(state: GameState) -> String {
        switch state {
        case .x:
            return NSLocalizedString("Player X", comment: "")
        case .o:
            return NSLocalizedString("Player Y", comment: "")
        }
    }
}
