//
//  LoadingOverlay.swift
//  MoneyBox
//
//  Created by Daniel Murphy on 01/04/2024.
//

import UIKit

class LoadingOverlay: UIView {
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        return spinner
    }()

    private let wrapperView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init() {
        super.init(frame: .zero)

        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupView() {
        wrapperView.addArrangedSubview(spinner)

        addSubview(wrapperView)

        NSLayoutConstraint.activate([
            wrapperView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            wrapperView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
        ])
    }
}
