//
//  UIView+Extension.swift
//  MoneyBox
//
//  Created by Marc Jardine Esperas on 8/16/22.
//

import UIKit

extension UIView {
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 2.0
        layer.masksToBounds = false
    }

    func addCornerRadius() {
        layer.cornerRadius = 10
    }
}
