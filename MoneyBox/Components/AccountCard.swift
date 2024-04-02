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

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
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

    init(account: ProductResponse) {
        self.account = account

        super.init(frame: .zero)

        setupViews()
        setupInitialValues()
        setupOnClick()
    }

    required init?(coder: NSCoder) {
        self.account = nil

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
        let accountDetailViewController = UIViewController()

        if let keyWindow = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first,
           let topViewController = keyWindow.rootViewController
        {
            topViewController.present(accountDetailViewController, animated: true)
        }
    }
}
