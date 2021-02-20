//
//  LocalizedNumberFormatterTest.swift
//  LocalizedNumberFieldTests
//
//  Created by 배지영 on 2021/02/09.
//

import XCTest
@testable import LocalizedNumberField

class LocalizedNumberFormatterTest: XCTestCase {
    
    private let log = Logger(logPlace: LocalizedNumberFormatterTest.self)
    private let numberFormatter: NumberFormatter = NumberFormatter()
    private let locale_enUS = Locale.en_US
    
    // "."은 0.0 으로 처리할 것
    let vaildAmounts = [
        "1234",
        "1,234",
        "1.2",
        "1,200.13",
        // 0으로 처리
        "",
        ".",
        //first or last가 decimalSeparator면 0 처리
        ".134", // 0.134
        "123.", // 123.0
        // 음수
        "-101010",
        "-1010.10",
        "-1,000.023",
        // 특수 숫자 섞일 경우
        "123१२३۱۲۳",
        "123१२३.۱۲۳",
        "123,१२३.۱۲۳"
    ]
    let invaildAmounts = [
        "0.0.1",
        "10️⃣0️⃣",
        "loo",
        "lzoo",
        "123.456,789"
    ]
    
    func testValueToNumber() throws {
        for vaild in vaildAmounts {
            let formatter = LocalizedNumberFormatter(from: locale_enUS, to: locale_enUS)
            XCTAssertNoThrow(try formatter.number(from: vaild))
        }
        for invaild in invaildAmounts {
            let formatter = LocalizedNumberFormatter(from: locale_enUS, to: locale_enUS)
            XCTAssertThrowsError(try formatter.number(from: invaild))
        }
    }
    
    let vaildAmountLocalizedStrings_enUS: [String: String] = [
        "1234": "1,234",
        "1,234": "1,234",
        "1.2": "1.2",
        "1,200.13": "1,200.13",
        // 0으로 처리
        "": "0",
        ".": "0",
        //first or last가 decimalSeparator면 0 처리
        ".134": "0.134",
        "123.": "123",
        // 음수
        "-101010": "-101,010",
        "-1010.10": "-1,010.1",
        "-1,000.023": "-1,000.023",
        // 특수 숫자 섞일 경우
        "123१२३۱۲۳": "123,123,123",
        "123१२३.۱۲۳": "123,123.123",
        "123,१२३.۱۲۳": "123,123.123"
    ]
    
    func testToLocalizedNumberString() throws {
        for vaildAmount in vaildAmounts {
            let formatter = LocalizedNumberFormatter(from: .current, to: .current)
            let localizedString = try formatter.localizedNumberString(from: vaildAmount, style: .decimal)
            XCTAssertEqual(vaildAmountLocalizedStrings_enUS[vaildAmount] ?? "", localizedString)
        }
        for invaildAmount in invaildAmounts {
            let formatter = LocalizedNumberFormatter(from: .current, to: .current)
            XCTAssertThrowsError(try formatter.localizedNumberString(from: invaildAmount, style: .decimal))
        }
        
    }
    
    func toNumber(value: String) throws -> NSNumber {
        numberFormatter.locale = locale_enUS
        let splitValues: (integer: String, decimal: String) = try splitToDecimal(to: locale_enUS, value: value)
        let integerValue: String = splitValues.integer.isEmpty
            ? "0" // ".12" -> "0.12"
            : splitValues.integer.replacingOccurrences(of: numberFormatter.groupingSeparator, with: "")
        let decimalValue: String = splitValues.decimal.isEmpty
            ? "0" // "1." -> "1.0"
            : splitValues.decimal
        guard false == (integerValue.contains(numberFormatter.decimalSeparator))
                && false == (decimalValue.contains(numberFormatter.groupingSeparator)) else {
            log.error(message: " value : \(value)\n - result : \(LocalizedNumberFormatterError.reverseSeparator)")
            throw LocalizedNumberFormatterError.reverseSeparator
        }
        guard let result = numberFormatter.number(from: integerValue + numberFormatter.decimalSeparator + decimalValue) else {
            log.error(message: " value : \(value)\n - result : \(LocalizedNumberFormatterError.invaildCharacters)")
            throw LocalizedNumberFormatterError.invaildCharacters
        }
        log.info(message: " value : \(value)\n - result : \(result)")
        return result
    }
    
    private func splitToDecimal(to locale: Locale, value: String) throws -> (integer: String, decimal: String) {
        guard false == value.isEmpty && "." != value else {
            return (integer: "0", decimal: "0")
        }
        let numberFormatter: NumberFormatter = NumberFormatter()
        numberFormatter.locale = locale
        let splitedValues: [String] = value.components(separatedBy: numberFormatter.decimalSeparator)
        guard splitedValues.count <= 2 else { // DecimalSeparator 두개 이상이면 에러
            log.error(message: " - value: \(value)\n - error: \(LocalizedNumberFormatterError.moreThanOneDecimalSeparator)")
            throw LocalizedNumberFormatterError.moreThanOneDecimalSeparator
        }
        if 1 == splitedValues.count {
            let result = (integer: splitedValues.first ?? "", decimal: "")
            return result
        }
        guard 2 == splitedValues.count else {
            // 유효하지 않은 포맷
            log.error(message: " - value: \(value)\n - error: \(LocalizedNumberFormatterError.unknown)")
            throw LocalizedNumberFormatterError.unknown
        }
        let integerValue = splitedValues.first!.replacingOccurrences(of: numberFormatter.groupingSeparator, with: "")
        let decimalValue = splitedValues.last!
        return (integer: integerValue, decimal: decimalValue)
    }
    
    
}


