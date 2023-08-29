//
//  ProductCollectionCell.swift
//  MoneyBox
//
//  Created by George Woodham on 25/08/23.
//

import MoneyBoxUI
import UIKit

final class ProductCollectionCell: UICollectionViewCell {
    
    static let identifier = "ProductCollectionViewCell"
    
    private lazy var productNameLabel = UILabel()
    private lazy var planValueLabel = UILabel()
    private lazy var moneyBoxAmountLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createLayout()
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewItem: ProductEntity) {
        productNameLabel.text = viewItem.name
        planValueLabel.text = viewItem.formattedPlanValue
        moneyBoxAmountLabel.text = viewItem.formattedMoneybox
    }
    
    private func createLayout() {
        let vstack = UIStackView()
        vstack.axis = .vertical
        vstack.alignment = .leading
        vstack.distribution = .fill
        vstack.spacing = 4
        vstack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(vstack)
        
        NSLayoutConstraint.activate([
            vstack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            vstack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            vstack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            vstack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        [productNameLabel,
         planValueLabel,
         moneyBoxAmountLabel
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.font = UIFont.preferredFont(forTextStyle: .body)
            $0.textColor = UIColor(named: "PrimaryText")
            vstack.addArrangedSubview($0)
        }
    }
}
