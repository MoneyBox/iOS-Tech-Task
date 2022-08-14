//
//  ProductTableHeaderView.swift
//  MoneyBox
//
//  Created by Marc Jardine Esperas on 8/16/22.
//

import UIKit
import Reusable

class ProductTableHeaderView: UITableViewHeaderFooterView, NibReusable {
    @IBOutlet weak private var greetingsLabel: UILabel!
    @IBOutlet weak private var totalPlanValueAmountLabel: UILabel!
    
    var accountHoldersName: String? {
        didSet {
            if let accountHoldersName = accountHoldersName {
                greetingsLabel.text = "Hello \(accountHoldersName)!"
                return
            }
            
            greetingsLabel.text = ""
        }
    }
    
    var totalPlanValueAmount: Double? {
        didSet {
            if let totalPlanValueAmount = totalPlanValueAmount {
                totalPlanValueAmountLabel.text = "£\(String(format: "%.2f", totalPlanValueAmount))"
                return
            }
            
            totalPlanValueAmountLabel.text = ""
        }
    }
}
