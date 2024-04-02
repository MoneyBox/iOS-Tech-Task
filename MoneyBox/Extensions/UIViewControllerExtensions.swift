//
//  UIViewControllerExtensions.swift
//  MoneyBox
//
//  Created by Daniel Murphy on 01/04/2024.
//

import UIKit

extension UIViewController {
    func showLoadingSpinner() {
        let loadingOverlay = LoadingOverlay()

        let screen = UIScreen.main.bounds
        loadingOverlay.center = CGPoint(x: screen.midX, y: screen.midY)
        loadingOverlay.tag = .loadingOverlayTag

        view.addSubview(loadingOverlay)
    }

    func dismissLoadingSpinner() {
        if let view = view.viewWithTag(.loadingOverlayTag) {
            view.removeFromSuperview()
        }
    }
}
