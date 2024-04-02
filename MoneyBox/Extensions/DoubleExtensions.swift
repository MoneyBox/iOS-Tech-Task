//
//  DoubleExtensions.swift
//  MoneyBox
//
//  Created by Daniel Murphy on 01/04/2024.
//

import Foundation

extension Double {
    func formatAsMoney() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "GBP"
        return formatter.string(from: NSNumber(value: self)) ?? "£--.--"
    }
}

extension Double? {
    func formatAsMoney() -> String {
        if let value = self {
            return value.formatAsMoney()
        }

        return "£--.--"
    }
}
