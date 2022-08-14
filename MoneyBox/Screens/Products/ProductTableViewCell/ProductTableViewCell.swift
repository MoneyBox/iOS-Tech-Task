//
//  ProductTableViewCell.swift
//  MoneyBox
//
//  Created by Marc Jardine Esperas on 8/16/22.
//

import UIKit
import Networking
import Reusable

class ProductTableViewCell: UITableViewCell, NibReusable {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak private var productNameLabel: UILabel!
    @IBOutlet weak private var planValueAmountLabel: UILabel!
    @IBOutlet weak private var moneyboxAmountLabel: UILabel!
    
    var product: ProductResponse? {
        didSet {
            self.resetValues()
            guard let product = product,
                  let productName = product.product?.name,
                  let planValue = product.planValue,
                  let moneybox = product.moneybox else {
                return
            }

            productNameLabel.text = productName
            planValueAmountLabel.text = "£\(String(format: "%.2f", planValue))"
            moneyboxAmountLabel.text = "£\(String(format: "%.2f", moneybox))"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        containerView.addShadow()
        containerView.addCornerRadius()
    }
    
    private func resetValues() {
        productNameLabel.text = ""
        planValueAmountLabel.text = ""
        moneyboxAmountLabel.text = ""
    }
    
}
