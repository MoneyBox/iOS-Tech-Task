//
//  Theme.swift
//  
//
//  Created by George Woodham on 25/08/23.
//

import Foundation

public struct Theme {
    public struct Constants {
        public static let padding: CGFloat = 16
    }
    
    public struct Formatters {
        public static let currency: NumberFormatter = {
            let nf = NumberFormatter()
            nf.locale = .current
            nf.numberStyle = .currency
            nf.maximumFractionDigits = 2
            return nf
        }()
    }
    
}
