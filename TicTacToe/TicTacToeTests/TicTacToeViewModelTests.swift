//
//  TicTacToeViewModelTests.swift
//  TicTacToeTests
//
//  Created by Erdi on 26.06.2021.
//

import XCTest
@testable  import TicTacToe

final class TicTacToeViewModelTests: XCTestCase { }

// MARK - Mark game board tests

extension TicTacToeViewModelTests {

    func testMarkGameBoardGameFinishedOWon() {
        let viewModel = TicTacToeViewModel()
        let gameEngine = GameEngine()

        gameEngine.gameState = .o
        gameEngine.ticTacToeMatrix = [
            [.x, .empty, .o],
            [.empty, .x, .o],
            [.x, .empty, .o]
        ]

        viewModel.gameEngine = gameEngine

        viewModel.stateChangeHandler = { state in
            switch state {
            case .gameFinished(let gameResult):
                XCTAssertEqual(gameResult, NSLocalizedString("O WON", comment: ""))
            default:
                break
            }
        }

        viewModel.markGameBoard(with: 8)

        let expectation = XCTestExpectation(description: "Wait for testing")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }

    func testMarkGameBoardGameFinishedXWon() {
        let viewModel = TicTacToeViewModel()
        let gameEngine = GameEngine()

        gameEngine.gameState = .o
        gameEngine.ticTacToeMatrix = [
            [.x, .o, .x],
            [.o, .x, .o],
            [.x, .empty, .empty]
        ]

        viewModel.gameEngine = gameEngine

        viewModel.stateChangeHandler = { state in
            switch state {
            case .gameFinished(let gameResult):
                XCTAssertEqual(gameResult, NSLocalizedString("X WON", comment: ""))
            default:
                break
            }
        }

        viewModel.markGameBoard(with: 8)

        let expectation = XCTestExpectation(description: "Wait for testing")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }

    func testMarkGameBoardGameFinishedAsDraw() {
        let viewModel = TicTacToeViewModel()
        let gameEngine = GameEngine()

        gameEngine.gameState = .o
        gameEngine.ticTacToeMatrix = [
            [.x, .o, .x],
            [.o, .x, .o],
            [.o, .x, .o]
        ]

        viewModel.gameEngine = gameEngine

        viewModel.stateChangeHandler = { state in
            switch state {
            case .gameFinished(let gameResult):
                XCTAssertEqual(gameResult, NSLocalizedString("DRAW", comment: ""))
            default:
                break
            }
        }

        viewModel.markGameBoard(with: 8)

        let expectation = XCTestExpectation(description: "Wait for testing")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }

    func testMarkGameBoardFilledCell() {
        let viewModel = TicTacToeViewModel()
        let gameEngine = GameEngine()

        gameEngine.gameState = .o
        gameEngine.ticTacToeMatrix = [
            [.x, .o, .empty],
            [.empty, .o, .x],
            [.empty, .empty, .x]
        ]

        viewModel.gameEngine = gameEngine

        let resultTypes = ["X", "O", "", "", "O", "X", "", "", "X"]

        viewModel.stateChangeHandler = { state in
            switch state {
            case .gameStateChanged(let types, let state):
                XCTAssertEqual(types, resultTypes, "Result types should be ")
                XCTAssertEqual(state, NSLocalizedString("Player O", comment: ""))
            default:
                break
            }
        }

        viewModel.markGameBoard(with: 8)

        let expectation = XCTestExpectation(description: "Wait for testing")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }

    func testMarkGameBoardEmptyCell() {
        let viewModel = TicTacToeViewModel()
        let gameEngine = GameEngine()

        gameEngine.gameState = .o
        gameEngine.ticTacToeMatrix = [
            [.x, .o, .empty],
            [.empty, .o, .x],
            [.empty, .empty, .empty]
        ]

        viewModel.gameEngine = gameEngine

        let resultTypes = ["X", "O", "", "", "O", "X", "", "", "O"]

        viewModel.stateChangeHandler = { state in
            switch state {
            case .gameStateChanged(let types, let state):
                XCTAssertEqual(types, resultTypes, "Result types should be equal")
                XCTAssertEqual(state, NSLocalizedString("Player X", comment: ""))
            default:
                break
            }
        }

        viewModel.markGameBoard(with: 8)

        let expectation = XCTestExpectation(description: "Wait for testing")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
}

// MARK - Needs to restart the game tests

extension TicTacToeViewModelTests {

    func testNeedsToRestartTheGameForPlayerStates() {
        let viewModel = TicTacToeViewModel()

        viewModel.stateChangeHandler = { state in
            switch state {
            case .gameStarted(_, let playerState):
                XCTAssertEqual(
                    playerState,
                    NSLocalizedString("Player X", comment: ""),
                    "Player state should be 'Player X'"
                )
            default:
                break
            }
        }

        viewModel.needsToRestartTheGame()

        let expectation = XCTestExpectation(description: "Wait for testing")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }

    func testNeedsToRestartTheGameForTypes() {

        let viewModel = TicTacToeViewModel()

        viewModel.stateChangeHandler = { state in
            switch state {
            case .gameStarted(let types, _):
                XCTAssertTrue(
                    types.first(where: { $0 != "" }) == nil,
                    "All types should be empty string"
                )
            default:
                break
            }
        }

        viewModel.needsToRestartTheGame()

        let expectation = XCTestExpectation(description: "Wait for testing")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
}
