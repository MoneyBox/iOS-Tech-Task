//
//  UIViewControllerExtensions.swift
//  MoneyBox
//
//  Created by Daniel Murphy on 01/04/2024.
//

import UIKit

extension UIViewController {
    func showLoadingSpinner() {
        let nib = UINib(nibName: "LoadingOverlay", bundle: nil)
        let customAlert = nib.instantiate(withOwner: self, options: nil).first as! LoadingOverlay

        let screen = UIScreen.main.bounds
        customAlert.center = CGPoint(x: screen.midX, y: screen.midY)
        customAlert.layer.cornerRadius = 8
        customAlert.tag = .loadingOverlayTag

        view.addSubview(customAlert)
    }

    func dismissLoadingSpinner() {
        if let view = view.viewWithTag(.loadingOverlayTag) {
            view.removeFromSuperview()
        }
    }
}
