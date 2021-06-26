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
}
