//
//  NSPredicateExtensions.swift
//  MoneyBox
//
//  Created by Daniel Murphy on 01/04/2024.
//

import Foundation

extension NSPredicate {
    static let emailRegEx: NSPredicate = {
        let emailRegExString = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        return NSPredicate(format: "SELF MATCHES %@", emailRegExString)
    }()
}
