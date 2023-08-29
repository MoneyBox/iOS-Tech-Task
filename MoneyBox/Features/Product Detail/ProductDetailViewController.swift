//
//  ProductDetailViewController.swift
//  MoneyBox
//
//  Created by George Woodham on 25/08/23.
//

import Combine
import MoneyBoxUI
import UIKit

final class ProductDetailViewController: UIViewController {
    
    let viewModel: ProductDetailViewModel
    
    private var bindings = Set<AnyCancellable>()
    
    init(viewModel: ProductDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var moneyboxLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = UIColor(named: "PrimaryText")
        return label
    }()
    
    private lazy var payButton: MBButton = {
        let button = MBButton(style: .primary)
        button.setTitle("Pay £10", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.product.name
        navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = UIColor(named: "GreyColor")
        
        createLayout()
        setupBindings()
    }
    
    private func createLayout() {
        let vstack = UIStackView()
        vstack.axis = .vertical
        vstack.alignment = .fill
        vstack.distribution = .fill
        vstack.spacing = Theme.Constants.padding
        vstack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vstack)
        
        NSLayoutConstraint.activate([
            vstack.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Theme.Constants.padding
            ),
            vstack.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Theme.Constants.padding
            ),
            vstack.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            )
        ])
        
        [moneyboxLabel,
         payButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            vstack.addArrangedSubview($0)
        }
    }
    
    private func setupBindings() {
        viewModel.$product
            .receive(on: DispatchQueue.main)
            .sink { [weak self] viewItem in
                self?.moneyboxLabel.text = viewItem.formattedMoneybox
            }
            .store(in: &bindings)
        
        payButton.tapPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.viewModel.addMoney()
            }
            .store(in: &bindings)
    }
    
}
