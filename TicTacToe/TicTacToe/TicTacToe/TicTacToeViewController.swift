//
//  TicTacToeViewController.swift
//  TicTacToe
//
//  Created by Erdi on 26.06.2021.
//

import UIKit

final class TicTacToeViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var stateLabel: UILabel!

    private var viewModel: TicTacToeViewModelInterface = TicTacToeViewModel()
    private var stateNames: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.stateChangeHandler = { [weak self] state in
            switch state {
            case .gameStarted(let types, let stateName):
                self?.updateStateAndCells(types: types, stateName: stateName)
            case .gameStateChanged(let types, let stateName):
                self?.updateStateAndCells(types: types, stateName: stateName)
            case.gameFinished(_):
                break
            }
        }
    }
}

// MARK - Private helper methods

private extension TicTacToeViewController {

    func updateStateAndCells(types: [String], stateName: String) {
        stateNames = types
        stateLabel.text = stateName
        collectionView.reloadData()
    }
}
