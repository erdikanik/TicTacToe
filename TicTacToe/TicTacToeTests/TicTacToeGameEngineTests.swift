//
//  TicTacToeGameEngineTests.swift
//  TicTacToeTests
//
//  Created by Erdi on 26.06.2021.
//

import XCTest
@testable  import TicTacToe

final class TicTacToeGameEngineTests: XCTestCase {

    private let gameEngine = GameEngine()
}

// MARK: - Mark and change game state tests

extension TicTacToeGameEngineTests {

    func testMarkAndChangeGameStateForEmptyMatrix() {

        gameEngine.gameState = .x
        gameEngine.ticTacToeMatrix = [
            [.empty, .empty, .empty],
            [.empty, .empty, .empty],
            [.empty, .empty, .empty]
        ]

        XCTAssertEqual(
            gameEngine.markAndChangeGameState(row: 0, column: 0),
            GameState.o,
            "Game state should be O")
    }

    func testMarkAndChangeGameStateForFilledCase() {
        gameEngine.gameState = .o
        gameEngine.ticTacToeMatrix = [
            [.x, .empty, .empty],
            [.empty, .empty, .empty],
            [.empty, .empty, .empty]
        ]

        XCTAssertEqual(
            gameEngine.markAndChangeGameState(row: 0, column: 0),
            GameState.o,
            "Game state should be O")
    }
}

// MARK: - Game result tests

extension TicTacToeGameEngineTests {

    func testGameResultForEmptyCase() {
        gameEngine.ticTacToeMatrix = [
            [.empty, .empty, .empty],
            [.empty, .empty, .empty],
            [.empty, .empty, .empty]
        ]

        XCTAssertEqual(.gameContinue, gameEngine.gameResult(), "Game should continue for empty matrix case")
    }

    func testGameResultXHorizontalWinnerCase() {
        gameEngine.ticTacToeMatrix = [
            [.o, .empty, .empty],
            [.x, .x, .x],
            [.x, .o, .o]
        ]

        XCTAssertEqual(.winX, gameEngine.gameResult(), "Game result should be x win in winner X vertical case")
    }

    func testGameResultOHorizontalWinnerCase() {
         gameEngine.ticTacToeMatrix = [
             [.x, .empty, .x],
             [.x, .empty, .x],
             [.o, .o, .o]
         ]

         XCTAssertEqual(.winO, gameEngine.gameResult(),
                        "Game result should be O win in winner O vertical case")
    }

    func testGameResultXVerticalWinnerCase() {
        gameEngine.ticTacToeMatrix = [
            [.x, .empty, .empty],
            [.x, .x, .o],
            [.x, .o, .o]
        ]

        XCTAssertEqual(.winX, gameEngine.gameResult(), "Game result should be X win in winner X horizontal case")
    }

    func testGameResultOVerticalWinnerCase() {
        gameEngine.ticTacToeMatrix = [
            [.x, .empty, .o],
            [.x, .empty, .o],
            [.empty, .x, .o]
        ]

        XCTAssertEqual(.winO, gameEngine.gameResult(), "Game result should be O win in O vertical case")
    }

    func testGameResultXCrossWinnerCase() {
        gameEngine.ticTacToeMatrix = [
            [.empty, .empty, .x],
            [.x, .x, .o],
            [.x, .o, .o]
        ]

        XCTAssertEqual(.winX, gameEngine.gameResult(), "Game result should be X win in winner X case")

        gameEngine.ticTacToeMatrix = [
            [.x, .empty, .o],
            [.x, .x, .o],
            [.empty, .o, .x]
        ]

        XCTAssertEqual(.winX, gameEngine.gameResult(), "Game result should be X win in winner X case")
    }

    func testGameResultOCrossWinnerCase() {
         gameEngine.ticTacToeMatrix = [
             [.x, .empty, .o],
             [.x, .o, .o],
             [.o, .x, .x]
         ]

         XCTAssertEqual(.winO, gameEngine.gameResult(), "Game result should be O win in winner O case")

        gameEngine.ticTacToeMatrix = [
            [.o, .x, .empty],
            [.x, .o, .o],
            [.x, .x, .o]
        ]

        XCTAssertEqual(.winO, gameEngine.gameResult(), "Game result should be O win in winner O case")
    }

    func testGameResultDrawCase() {
         gameEngine.ticTacToeMatrix = [
             [.o, .x, .o],
             [.x, .o, .x],
             [.x, .o, .x]
         ]

         XCTAssertEqual(.draw, gameEngine.gameResult(), "Game result should be draw in draw case")
     }

    func testGameResultContinueCase() {
        gameEngine.ticTacToeMatrix = [
            [.empty, .x, .o],
            [.x, .o, .empty],
            [.x, .o, .x]
        ]

        XCTAssertEqual(.gameContinue, gameEngine.gameResult(), "Game should continue for in this case")
    }
}
