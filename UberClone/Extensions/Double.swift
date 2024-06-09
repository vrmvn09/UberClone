//
//  Double.swift
//  UberClone
//
//  Created by Arman  Urstem on 09.06.2024.
//

import Foundation

extension Double {
    
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }
    
    func toCurrency() -> String {
        return currencyFormatter.string(for: self) ?? ""
    }
}
