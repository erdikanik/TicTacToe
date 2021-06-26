//
//  UIView+Extensions.swift
//  TicTacToe
//
//  Created by Erdi on 27.06.2021.
//

import UIKit

extension UIView {

    static func reuseIdentifier() -> String {
        return String(describing: self)
    }

    static func nibName() -> String {
        return String(describing: self)
    }
}
