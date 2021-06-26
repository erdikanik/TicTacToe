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
}
