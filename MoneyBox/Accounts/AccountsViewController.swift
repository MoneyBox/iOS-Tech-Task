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

    init(viewModel: AccountsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        viewModel = AccountsViewModel()
        super.init(coder: coder)
    }

    let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()

    let totalPlanValueLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()

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
        mainStack.addArrangedSubview(welcomeLabel)
        mainStack.addArrangedSubview(totalPlanValueLabel)

        view.addSubview(mainStack)

        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            mainStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .defaultLeadingContstraint),
            mainStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: .defaultTrailingContstraint),
        ])
    }

    private func updateUi(for state: FetchState) {
        switch state {
        case .fetching: showLoadingSpinner()
        case .fetched: updateUiForSuccess()
        case let .error(error): updateUiForFaliure(with: error)
        default: return
        }
    }

    private func updateUiForSuccess() {
        welcomeLabel.text = "Welcome \(viewModel.user?.firstName ?? "")!"
        totalPlanValueLabel.text = "Total Plan Value: \(viewModel.getFormattedTotalPlanValue())"

        dismissLoadingSpinner()
    }

    private func updateUiForFaliure(with _: Error) {
        dismissLoadingSpinner()
    }
}
