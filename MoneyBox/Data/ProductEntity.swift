//
//  ProductEntity.swift
//  MoneyBox
//
//  Created by George Woodham on 25/08/23.
//

import Foundation
import MoneyBoxUI
import Networking

struct ProductEntity: Hashable, Equatable {
    var id: Int?
    var name: String?
    var planValue: Double?
    var moneybox: Double?
    
    init(dto: ProductResponse) {
        id = dto.id
        name = dto
            .product?
            .friendlyName
        planValue = dto.planValue
        moneybox = dto.moneybox
    }
    
    init(
        id: Int? = nil,
        name: String? = nil,
        planValue: Double? = nil,
        moneybox: Double? = nil
    ) {
        self.id = id
        self.name = name
        self.planValue = planValue
        self.moneybox = moneybox
    }
}

extension ProductEntity {
    var formattedPlanValue: String? {
        planValue
            .flatMap {
                Theme.Formatters
                    .currency
                    .string(from: NSNumber(value: $0))
            }
            .map { "Plan Value: \($0)" }
    }
    
    var formattedMoneybox: String? {
        moneybox
        .flatMap {
            Theme.Formatters
                .currency
                .string(from: NSNumber(value: $0))
        }
        .map { "Moneybox: \($0)" }
    }
}
