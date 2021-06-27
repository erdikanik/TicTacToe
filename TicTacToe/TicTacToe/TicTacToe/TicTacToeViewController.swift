//
//  TicTacToeViewController.swift
//  TicTacToe
//
//  Created by Erdi on 26.06.2021.
//

import UIKit

final class TicTacToeViewController: UIViewController {

    private enum Constant {

        static let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        static let numberOfRows: CGFloat = 3
        static let gridRowThreshold: CGFloat = 3.5
    }

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var stateLabel: UILabel!

    private var viewModel: TicTacToeViewModelInterface = TicTacToeViewModel()
    private var stateNames: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView?.register(
            UINib.init(nibName: TicTacToeGridCell.reuseIdentifier(),
                       bundle: Bundle.main),
            forCellWithReuseIdentifier: TicTacToeGridCell.reuseIdentifier())

        viewModel.stateChangeHandler = { [weak self] state in
            switch state {
            case .gameStarted(let types, let stateName):
                self?.updateStateAndCells(types: types, stateName: stateName)
            case .gameStateChanged(let types, let stateName):
                self?.updateStateAndCells(types: types, stateName: stateName)
            case.gameFinished(let message):
                self?.createAlertController(with: message)
                break
            }
        }

        viewModel.needsToRestartTheGame()
    }
}

// MARK - Private helper methods

private extension TicTacToeViewController {

    func updateStateAndCells(types: [String], stateName: String) {
        stateNames = types
        stateLabel.text = stateName
        collectionView.reloadData()
    }

    func createAlertController(with message: String) {

        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { [weak self] _ in
            self?.viewModel.needsToRestartTheGame()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: UICollectionViewDataSource

extension TicTacToeViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stateNames.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TicTacToeGridCell.reuseIdentifier(),
            for: indexPath) as! TicTacToeGridCell

        cell.contentView.layer.borderColor = UIColor.gray.cgColor
        cell.contentView.layer.borderWidth = 2

        let markerName = stateNames[indexPath.row]
        cell.markerName = markerName

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.markGameBoard(with: indexPath.row)
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension TicTacToeViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = (view.frame.width - Constant.numberOfRows * Constant.sectionInsets.left) / Constant.gridRowThreshold

        return CGSize(width: width , height: width)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return Constant.sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constant.sectionInsets.left
    }
}
