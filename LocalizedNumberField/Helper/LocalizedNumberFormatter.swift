//
//  LocalizedNumberFormatter.swift
//  LocalizedNumberField
//
//  Created by 배지영 on 2021/02/09.
//

import Foundation

class LocalizedNumberFormatter: LocalizedNumberFormatterDataSource {
    
    var fromLocale: Locale
    var toLocale: Locale
    var amount: String
    
    init(from: Locale = .current, to: Locale = .current, amount: String) {
        self.fromLocale = from
        self.toLocale = to
        self.amount = amount
    }
    
    func toLocalizedNumber(numberStyle: NumberFormatter.Style) throws -> String {
        let numberFormatter: NumberFormatter = NumberFormatter()
        numberFormatter.locale = fromLocale
        let splitAmount = self.amount
            .replacingOccurrences(of: numberFormatter.groupingSeparator, with: "")
            .replacingOccurrences(of: numberFormatter.decimalSeparator, with: ".")
            .split(separator: ".")
            .map { String($0) }
        guard 1 == splitAmount.count || 2 == splitAmount.count else {
            throw LocalizedNumberFormatterError.notIntegerOrDecimal
        }
        let numbers: (integerString: String, decimalString: String) =
            1 == splitAmount.count
            ? (splitAmount.first!, "0")
            : (splitAmount.first!, splitAmount.last!)
        guard let integer = Int(numbers.integerString),
              let decimal = Int(numbers.decimalString) else {
            throw LocalizedNumberFormatterError.notNumber
        }
        numberFormatter.locale = toLocale
        numberFormatter.numberStyle = numberStyle
        guard let number = Double("\(integer).\(decimal)"),
              let result = numberFormatter.string(for: number) else {
            throw LocalizedNumberFormatterError.notNumber
        }
        return result
    }
    
}
