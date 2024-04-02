//
//  AccountCard.swift
//  MoneyBox
//
//  Created by Daniel Murphy on 02/04/2024.
//

import Networking
import UIKit

class AccountCard: UIView {
    private var account: ProductResponse?

    private var onClickCallback: (() -> Void)?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    private let planValueLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    private let moneyboxLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.backgroundColor = .clear
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    init(account: ProductResponse, onClickCallback: @escaping () -> Void) {
        self.account = account
        self.onClickCallback = onClickCallback

        super.init(frame: .zero)

        setupViews()
        setupInitialValues()
        setupOnClick()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupViews() {
        backgroundColor = .accent
        layer.cornerRadius = 8

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(planValueLabel)
        stackView.addArrangedSubview(moneyboxLabel)

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }

    private func setupInitialValues() {
        if let title = account?.product?.friendlyName {
            titleLabel.text = title
        }

        if let planValue = account?.planValue {
            planValueLabel.text = "Plan value: \(planValue.formatAsMoney())"
        }

        if let moneybox = account?.moneybox {
            moneyboxLabel.text = "Moneybox: \(moneybox.formatAsMoney())"
        }
    }

    private func setupOnClick() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onClick))
        addGestureRecognizer(tapGesture)
        isUserInteractionEnabled = true
    }

    @objc private func onClick() {
        onClickCallback?()
    }
}
