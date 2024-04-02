//
//  AccountsViewController.swift
//  MoneyBox
//
//  Created by Daniel Murphy on 01/04/2024.
//

import Networking
import UIKit

class AccountsViewController: UIViewController {
    let viewModel: AccountsViewModel

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

    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    let totalPlanValueLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    let accountsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    init(viewModel: AccountsViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        viewModel = AccountsViewModel()

        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Accounts"
        navigationItem.hidesBackButton = true

        view.backgroundColor = .systemBackground

        setupViews()
    }

    override func viewWillAppear(_: Bool) {
        viewModel.updateUiHook = updateUi
        viewModel.fetchAccountDetails()
    }

    private func setupViews() {
        labelsStack.addArrangedSubview(welcomeLabel)
        labelsStack.addArrangedSubview(totalPlanValueLabel)

        mainStack.addArrangedSubview(labelsStack)
        mainStack.addArrangedSubview(accountsStack)

        view.addSubview(mainStack)

        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            mainStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .defaultLeadingContstraint),
            mainStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: .defaultTrailingContstraint),
        ])
    }

    private func updateUi(for state: FetchState) {
        resetUi()

        switch state {
        case .fetching: showLoadingSpinner()
        case .fetched: updateUiForSuccess()
        case let .error(error): updateUiForFaliure(with: error)
        default: return
        }
    }

    private func resetUi() {
        welcomeLabel.text = ""
        totalPlanValueLabel.text = ""
        accountsStack.arrangedSubviews.forEach { accountsStack.removeArrangedSubview($0) }
    }

    private func updateUiForSuccess() {
        welcomeLabel.text = "Welcome \(viewModel.user?.firstName ?? "")!"
        totalPlanValueLabel.text = "Total Plan Value: \(viewModel.getFormattedTotalPlanValue())"

        if let accounts = viewModel.accountResponse?.productResponses {
            for account in accounts {
                accountsStack.addArrangedSubview(
                    AccountCard(account: account) {
                        let viewModel = AccountDetailsViewModel(account: account)
                        let viewController = AccountDetailsViewController(viewModel: viewModel)
                        self.navigationController?.pushViewController(viewController, animated: true)
                    }
                )
            }
        }

        dismissLoadingSpinner()
    }

    private func updateUiForFaliure(with _: Error) {
        dismissLoadingSpinner()

        let alertController = UIAlertController(
            title: "Something went wrong",
            message: "An error occured while attempting to retreive your accounts, please try again",
            preferredStyle: .alert
        )

        let action = UIAlertAction(title: "Try Again", style: .default) { _ in
            self.viewModel.fetchAccountDetails()
        }

        alertController.addAction(action)

        present(alertController, animated: true)
    }
}
