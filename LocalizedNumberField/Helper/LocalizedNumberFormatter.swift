//
//  LocalizedNumberFormatter.swift
//  LocalizedNumberField
//
//  Created by 배지영 on 2021/02/09.
//

import Foundation

class LocalizedNumberFormatter: LocalizedNumberFormatterDataSource {
    
    typealias ConvertedError = LocalizedNumberFormatterError
    
    var fromLocale: Locale
    var toLocale: Locale
    
    private let log: Logger = Logger(logPlace: LocalizedNumberFormatter.self)
    
    init(from: Locale, to: Locale) {
        self.fromLocale = from
        self.toLocale = to
    }
    
}

extension LocalizedNumberFormatter {
    
    func number(from value: String) throws -> NSNumber {
        let numberFormatter: NumberFormatter = NumberFormatter()
        numberFormatter.locale = fromLocale
        let splitValues: (integer: String, decimal: String) = try splitToDecimal(locale: fromLocale, value: value)
        let integerValue: String = splitValues.integer.isEmpty
            ? "0" // ".12" -> "0.12"
            : splitValues.integer.replacingOccurrences(of: numberFormatter.groupingSeparator, with: "")
        let decimalValue: String = splitValues.decimal.isEmpty
            ? "0" // "1." -> "1.0"
            : splitValues.decimal
        guard false == (integerValue.contains(numberFormatter.decimalSeparator))
                && false == (decimalValue.contains(numberFormatter.groupingSeparator)) else {
            log.error(message: " - value : \(value)\n - result : \(ConvertedError.reverseSeparator)")
            throw ConvertedError.reverseSeparator
        }
        guard let result = numberFormatter.number(from: integerValue + numberFormatter.decimalSeparator + decimalValue) else {
            log.error(message: " - value : \(value)\n - result : \(ConvertedError.invaildCharacters)")
            throw ConvertedError.invaildCharacters
        }
        log.info(message: " - value : \(value)\n - result : \(result)")
        return result
    }
    
    private func splitToDecimal(locale: Locale, value: String) throws -> (integer: String, decimal: String) {
        guard false == value.isEmpty && "." != value else {
            return (integer: "0", decimal: "0")
        }
        let numberFormatter: NumberFormatter = NumberFormatter()
        numberFormatter.locale = locale
        let splitedValues: [String] = value.components(separatedBy: numberFormatter.decimalSeparator)
        guard splitedValues.count <= 2 else { // DecimalSeparator 두개 이상이면 에러
            log.error(message: " - value: \(value)\n - error: \(ConvertedError.moreThanOneDecimalSeparator)")
            throw ConvertedError.moreThanOneDecimalSeparator
        }
        if 1 == splitedValues.count {
            let result = (integer: splitedValues.first ?? "", decimal: "")
            return result
        }
        guard 2 == splitedValues.count else {
            // 유효하지 않은 포맷
            log.error(message: " - value: \(value)\n - error: \(ConvertedError.unknown)")
            throw ConvertedError.unknown
        }
        let integerValue = splitedValues.first!.replacingOccurrences(of: numberFormatter.groupingSeparator, with: "")
        let decimalValue = splitedValues.last!
        return (integer: integerValue, decimal: decimalValue)
    }
    
}

extension LocalizedNumberFormatter {
    
    func localizedNumberString(from value: String, style: NumberFormatter.Style) throws -> String {
        do {
            let number: NSNumber = try self.number(from: value)
            let numberFormatter: NumberFormatter = NumberFormatter()
            numberFormatter.locale = toLocale
            numberFormatter.numberStyle = style
            guard let localizedString = numberFormatter.string(from: number) else {
                log.error(message: " - value : \(value)\n - error : \(ConvertedError.notConvertedNSNumberToLocalizedString)")
                throw ConvertedError.notConvertedNSNumberToLocalizedString
            }
            log.info(message: " - value : \(value)\n - result : \(localizedString)")
            return localizedString
        } catch {
            throw error
        }
    }
    
}
