//
//  ProductDetailsViewController.swift
//  MoneyBox
//
//  Created by Marc Jardine Esperas on 8/16/22.
//

import UIKit
import Reusable

final class ProductDetailsViewController: UIViewController, ViewModelBased {
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var planValueAmountLabel: UILabel!
    @IBOutlet weak var moneyBoxAmountLabel: UILabel!
    @IBOutlet weak var addMoneyButton: UIButton!
    
    var viewModel: ProductDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUI()
        
        showProductDetails()
    }
    
    private func loadUI() {
        addMoneyButton.addCornerRadius()
        addMoneyButton.addShadow()
    }
    
    private func showProductDetails() {
        let productName = viewModel.productName()
        let planValueAmount = viewModel.planValueAmount()
        productNameLabel.text = productName
        planValueAmountLabel.text = planValueAmount
        updateMoneybox()
    }
    
    private func updateMoneybox() {
        let moneyboxAmount = viewModel.moneyboxAmount()
        moneyBoxAmountLabel.text = moneyboxAmount
    }
    
    private func addMoney() {
        ActivityIndicator.start(for: view)
        viewModel.addMoney { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success():
                    self?.updateMoneybox()
                case .failure(let error):
                    self?.showAlert(message: error.localizedDescription)
                }
            }
            ActivityIndicator.stop()
        }
    }
    
    @IBAction func addMoneyButtonPressed(_ sender: UIButton) {
        addMoney()
    }
}

// MARK: - StoryboardSceneBased
extension ProductDetailsViewController: StoryboardSceneBased {
    public static var sceneStoryboard: UIStoryboard {
        UIStoryboard(name: "ProductDetails", bundle: nil)
    }
}
