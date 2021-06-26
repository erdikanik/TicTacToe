//
//  TicTacToeGridCell.swift
//  TicTacToe
//
//  Created by Erdi on 26.06.2021.
//

import UIKit

final class TicTacToeGridCell: UICollectionViewCell {

    @IBOutlet private weak var markerLabel: UILabel!

    var markerName: String = "" {
        didSet {
            markerLabel.text = markerName
        }
    }
}
