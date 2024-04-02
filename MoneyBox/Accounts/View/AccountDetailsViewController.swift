//
//  AccountDetailsViewController.swift
//  MoneyBox
//
//  Created by Daniel Murphy on 02/04/2024.
//

import Networking
import UIKit

class AccountDetailsViewController: UIViewController {
    let viewModel: AccountDetailsViewModel

    let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 32
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    let labelsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    let planValueLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    let moneyboxLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    let addMoneyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add £10.00", for: .normal)
        button.setTitleColor(.white, for: .normal)

        button.backgroundColor = .accent
        button.layer.cornerRadius = 8

        button.addTarget(self, action: #selector(addMoneyButtonTapped), for: .touchUpInside)

        button.translatesAutoresizingMaskIntoConstraints = false

        button.titleLabel?.font = .preferredFont(forTextStyle: .title3)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.accessibilityHint = "Login Button"
        return button
    }()

    init(viewModel: AccountDetailsViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        viewModel = AccountDetailsViewModel()

        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupLabelValues()
    }

    private func setupViews() {
        view.backgroundColor = .systemBackground

        labelsStack.addArrangedSubview(planValueLabel)
        labelsStack.addArrangedSubview(moneyboxLabel)

        mainStack.addArrangedSubview(labelsStack)
        mainStack.addArrangedSubview(addMoneyButton)

        view.addSubview(mainStack)

        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            mainStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .defaultLeadingContstraint),
            mainStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: .defaultTrailingContstraint),
        ])
    }

    private func setupLabelValues() {
        if let title = viewModel.account?.product?.friendlyName {
            self.title = title
        }

        if let planValue = viewModel.account?.planValue {
            planValueLabel.text = "Plan value: \(planValue.formatAsMoney())"
        }

        if let moneybox = viewModel.account?.moneybox {
            moneyboxLabel.text = "Moneybox: \(moneybox.formatAsMoney())"
        }
    }

    @objc private func addMoneyButtonTapped() {
        addMoney()
    }

    private func addMoney() {
        showLoadingSpinner()

        viewModel.addMoneyToAccount { response in
            switch response {
            case let .success(success): self.handleSuccessfulMoneyAddition(with: success.moneybox)
            case .failure: self.handleFailedMoneyAddition()
            }
        }
    }

    private func handleSuccessfulMoneyAddition(with newValue: Double?) {
        dismissLoadingSpinner()

        moneyboxLabel.text = "Moneybox: \(newValue.formatAsMoney())"
    }

    private func handleFailedMoneyAddition() {
        dismissLoadingSpinner()

        let alertController = UIAlertController(
            title: "An Error Occurred",
            message: "An error occured when adding money to this account, please try again",
            preferredStyle: .alert
        )

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        let retryAction = UIAlertAction(title: "Try Again", style: .default) { _ in
            self.addMoney()
        }

        alertController.addAction(cancelAction)
        alertController.addAction(retryAction)

        present(alertController, animated: true)
    }
}
