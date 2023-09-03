//
//  AccountsViewController.swift
//  MoneyBox
//
//  Created by David Gray on 03/09/2023.
//

import UIKit

final class AccountsViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: AccountsViewModel
    
    // MARK: - Init
    init(accountsViewModel: AccountsViewModel) {
        self.viewModel = accountsViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
