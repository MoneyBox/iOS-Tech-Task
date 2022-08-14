//
//  ProductsViewController.swift
//  MoneyBox
//
//  Created by Marc Jardine Esperas on 8/16/22.
//

import UIKit
import Reusable

protocol ProductsViewControllerProtocol {
    func gotoProductDetailsViewController(viewModel: ProductDetailsViewModel)
}

final class ProductsViewController: UIViewController, ViewModelBased {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ProductsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        hideNavigationbar()
        fetchProducts()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        showNavigationbar()
    }
    
    private func configureTableView() {
        tableView.register(headerFooterViewType: ProductTableHeaderView.self)
        tableView.register(cellType: ProductTableViewCell.self)
        
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
    }
    
// MARK: API Calls
    private func fetchProducts() {
        ActivityIndicator.start(for: view)
        viewModel.fetchProducts { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success():
                    self?.tableView.dataSource = self
                    self?.tableView.delegate = self
                    self?.tableView.reloadData()
                case .failure(let error):
                    self?.showAlert(message: error.localizedDescription)
                }
            }
            ActivityIndicator.stop()
        }
    }
}

// MARK: UITableViewDataSource
extension ProductsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProductTableViewCell = self.tableView.dequeueReusableCell(for: indexPath)
        
        cell.product = viewModel.product(at: indexPath.row)
        
        return cell
    }
}

// MARK: UITableViewDelegate
extension ProductsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let tableHeaderView = tableView.dequeueReusableHeaderFooterView(ProductTableHeaderView.self) else {
            return nil
        }
        
        let accountHoldersName = viewModel.accountHoldersName()
        let totalPlanValueAmount = viewModel.totalPlanValueAmount()
        tableHeaderView.accountHoldersName = accountHoldersName
        tableHeaderView.totalPlanValueAmount = totalPlanValueAmount
        
        return tableHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = viewModel.product(at: indexPath.row)
        let viewModel = ProductDetailsViewModel(product: product)
        gotoProductDetailsViewController(viewModel: viewModel)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ProductsViewController: ProductsViewControllerProtocol {
    func gotoProductDetailsViewController(viewModel: ProductDetailsViewModel) {
        let viewController = ProductDetailsViewController.instantiate(with: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - StoryboardSceneBased
extension ProductsViewController: StoryboardSceneBased {
    public static var sceneStoryboard: UIStoryboard {
        UIStoryboard(name: "Products", bundle: nil)
    }
}
