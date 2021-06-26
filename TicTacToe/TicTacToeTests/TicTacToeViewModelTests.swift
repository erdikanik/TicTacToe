//
//  TicTacToeViewModelTests.swift
//  TicTacToeTests
//
//  Created by Erdi on 26.06.2021.
//

import XCTest
@testable  import TicTacToe

final class TicTacToeViewModelTests: XCTestCase { }

// MARK - Needs to restart the game tests

extension TicTacToeViewModelTests {

    func testNeedsToRestartTheGameForTypes() {

        let viewModel = TicTacToeViewModel()

        viewModel.stateChangeHandler = { state in
            switch state {
            case .gameStarted(let types, _):
                XCTAssertTrue(
                    !types.contains(where: { $0 == .x || $0 == .o }),
                    "All TicTocToe types should be empty"
                )
            default:
                break
            }
        }

        viewModel.needsToRestartTheGame()

        let expectation = XCTestExpectation(description: "Wait for testing")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.2)
    }
}
