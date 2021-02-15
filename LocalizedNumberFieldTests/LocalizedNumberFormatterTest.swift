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
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
//    func testToLocalizedNumberString() throws {
//        let formatter1 = LocalizedNumberFormatter(amount: "10000")
//        XCTAssertEqual(try formatter1.toLocalizedNumber(numberStyle: .decimal), "10,000")
//        log.info(message: try formatter1.toLocalizedNumber(numberStyle: .decimal))
//        
//        let formatter2 = LocalizedNumberFormatter(amount: "0.1")
//        XCTAssertEqual(try formatter2.toLocalizedNumber(numberStyle: .decimal), "0.1")
//        log.info(message: try formatter2.toLocalizedNumber(numberStyle: .decimal))
//        
//        let formatter3 = LocalizedNumberFormatter(amount: "0.0.1")
//        do {
//            let error = try formatter3.toLocalizedNumber(numberStyle: .decimal)
//            XCTAssertThrowsError(error)
//        } catch {
//            log.error(message: error)
//        }
//        
//        let formatter4 = LocalizedNumberFormatter(amount: "숫자아님1")
//        do {
//            let error = try formatter4.toLocalizedNumber(numberStyle: .decimal)
//            XCTAssertThrowsError(error)
//        } catch {
//            log.error(message: error)
//        }
//        
//        let formatter5 = LocalizedNumberFormatter(from: Locale.ko_KR, to: Locale.ko_KR, amount: "10000.674")
//        XCTAssertEqual(try formatter5.toLocalizedNumber(numberStyle: .decimal), "10,000.674")
//        log.info(message: try formatter5.toLocalizedNumber(numberStyle: .decimal))
//        
//        let formatter6 = LocalizedNumberFormatter(from: Locale.ko_KR, to: Locale(identifier: "fr_FR"), amount: "1,234.568")
//        XCTAssertEqual(try formatter6.toLocalizedNumber(numberStyle: .decimal), "1 234,568")
//        log.info(message: try formatter6.toLocalizedNumber(numberStyle: .decimal))
//        
//        let formatter7 = LocalizedNumberFormatter(from: Locale.ko_KR, to: Locale(identifier: "fr_FR"), amount: "10000.674")
//        XCTAssertEqual(try formatter7.toLocalizedNumber(numberStyle: .decimal), "10 000,674")
//        log.info(message: try formatter7.toLocalizedNumber(numberStyle: .decimal))
//        
//        let formatter8 = LocalizedNumberFormatter(from: Locale.ko_KR, to: Locale(identifier: "ne"), amount: "123456789.123")
//        XCTAssertEqual(try formatter8.toLocalizedNumber(numberStyle: .decimal), "१२३,४५६,७८९.१२३")
//        log.info(message: try formatter8.toLocalizedNumber(numberStyle: .decimal))
//        
//        let formatter9 = LocalizedNumberFormatter(from: Locale(identifier: "ne"), to: Locale.ko_KR, amount: "१२३,४५६,७८९")
//        XCTAssertEqual(try formatter9.toLocalizedNumber(numberStyle: .decimal), "123456789")
//        log.info(message: try formatter9.toLocalizedNumber(numberStyle: .decimal))
//    }
//    
//    func testExample_numberFormatter() throws {
//        let numberFormatter: NumberFormatter = NumberFormatter()
//        numberFormatter.numberStyle = .decimal // 💛 important
//        let numbers_en: [String] = [
//            "123",
//            "123456789",
//            "123456789.123",
//            "123,456,789.123"
//        ]
//        let numbers_ne: [String] = [
//            "१२३",
//            "१२३४५६७८९",
//            "१२३४५६७८९.१२३",
//            "१२३,४५६,७८९.१२३"
//        ]
//        /// locale : ne
//        for index in 0...numbers_en.count-1 {
//            let number_en = numbers_en[index]
//            let number_ne = numbers_ne[index]
//            numberFormatter.locale = Locale(identifier: "ne") // ne
//            // Origin Number String -> NSNumber
//            guard let num_en = numberFormatter.number(from: number_en),
//                  let num_ne = numberFormatter.number(from: number_ne) else {
//                let num_en = numberFormatter.number(from: number_en)
//                let num_ne = numberFormatter.number(from: number_ne)
//                log.error(message: debugMessage(from: "en", to: "ne", origin_from: number_en, origin_to: number_ne, num_from: num_en, num_to: num_ne))
//                continue
//            }
//            XCTAssertNotNil(num_en)
//            XCTAssertNotNil(num_ne)
//            XCTAssertEqual(num_ne, num_en)
//            // NSNumber -> Localized Number String
//            guard let numberString_en = numberFormatter.string(from: num_en),
//                  let numberString_ne = numberFormatter.string(from: num_ne) else {
//                let numberString_en = numberFormatter.string(from: num_en)
//                let numberString_ne = numberFormatter.string(from: num_ne)
//                log.error(message: debugMessage(from: "en", to: "ne", origin_from: number_en, origin_to: number_ne, num_from: num_en, num_to: num_ne, numberString_from: numberString_en, numberString_to: numberString_ne))
//                continue
//            }
//            XCTAssertNotNil(numberString_en)
//            XCTAssertNotNil(numberString_ne)
//            XCTAssertEqual(numberString_en, numberString_ne)
//            log.info(message: debugMessage(from: "en", to: "ne", origin_from: number_en, origin_to: number_ne, num_from: num_en, num_to: num_ne, numberString_from: numberString_en, numberString_to: numberString_ne))
//        }
//    }
//    
//    func testMatchingPureNumber() throws {
//        let pure_numbers: [NSNumber] = [
//            NSNumber(value: 123),
//            NSNumber(value: 123.4),
//            NSNumber(value: 123456789),
//            NSNumber(value: 123456789.123)
//        ]
//        let numbers_en: [String] = [
//            "123",
//            "123.4",
//            "123,456,789",
//            "123,456,789.123"
//        ]
//        let numbers_ne: [String] = [
//            "१२३",
//            "१२३.४",
//            "१२३,४५६,७८९",
//            "१२३,४५६,७८९.१२३"
//        ]
//        let numbers_ur_IN: [String] = [
//            "۱۲۳",
//            "۱۲۳٫۴",
//            "۱۲۳٬۴۵۶٬۷۸۹",
//            "۱۲۳٬۴۵۶٬۷۸۹٫۱۲۳"
//        ]
//        let numbers_fr_FR: [String] = [
//            "123",
//            "123,4",
//            "123 456 789",
//            "123 456 789,123"
//        ]
//        let identifiers: [String: [String]] = [
//            "en_US": numbers_en,
//            "ne": numbers_ne,
//            "ur_IN": numbers_ur_IN,
//            "fr_FR": numbers_fr_FR
//        ]
//        for (identifier, numbers) in identifiers {
//            for index in 0...numbers.count - 1 {
//                let currentPureNumber = pure_numbers[index]
//                let numberFormatter = NumberFormatter()
//                numberFormatter.numberStyle = .decimal
//                numberFormatter.locale = Locale(identifier: identifier)
//                let localizedNumberString = numberFormatter.string(from: currentPureNumber)
//                XCTAssertEqual(localizedNumberString, numbers[index])
//            }
//        }
//    }
//    
    
    func testErrorNumberCheck() throws {
        
//        let ur_IN = NumberFormatter()
//        ur_IN.locale = Locale(identifier: "ur_IN")
//
//        /// ⚠️ not correct identifier
//        let errorNumbers: [String] = [
//            // ur_IN
//            "۱۲۳",
//            "۱۲۳۴۵۶۷۸۹",
//            "۱۲۳٬۴۵۶٬۷۸۹٫۱۲۳",
//            // fr_FR
//            "1 234",
//            "1 234,568",
//            "1,203" // == Double(1.203)
//        ]
//        let errorKey = [
//            "۱۲۳": "ur_IN",
//            "۱۲۳۴۵۶۷۸۹": "ur_IN",
//            "۱۲۳٬۴۵۶٬۷۸۹٫۱۲۳": "ur_IN",
//            "1 234": "fr_FR",
//            "1 234,568": "fr_FR",
//            "1,203": "fr_FR"
//        ]
//        for index in 0...numbers_ne.count - 1 {
//            let origin = numbers_ne[index]
//            let error = errorNumbers[index]
//            let errorIdentifier = errorKey[error]
//            // Origin Number String -> NSNumber
//            let num_origin = numberFormatter.number(from: origin)!
//            guard let num_error = numberFormatter.number(from: error) else {
//                log.error(
//                    message: debugMessage(
//                        originIdentifier: identifier,
//                        compareIdentifier: errorIdentifier ?? "?",
//                        origin: origin,
//                        compare: error,
//                        num_origin: num_origin
//                    )
//                )
//                continue
//            }
//            // NSNumber -> Localized Number String
//            let numberString_origin = numberFormatter.string(from: num_origin)!
//            guard let numberString_error = numberFormatter.string(from: num_error) else {
//                log.error(
//                    message: debugMessage(
//                        originIdentifier: identifier,
//                        compareIdentifier: errorIdentifier ?? "?",
//                        origin: origin,
//                        compare: error,
//                        num_origin: num_origin,
//                        num_compare: num_error,
//                        numberString_origin: numberString_origin
//                    )
//                )
//                continue
//            }
//            XCTAssertNotEqual(numberString_origin, numberString_error) // 설정한 identifier가 다르면 값이 달라야 한다
//            log.info(
//                message: debugMessage(
//                    originIdentifier: identifier,
//                    compareIdentifier: errorIdentifier ?? "?",
//                    origin: origin,
//                    compare: error,
//                    num_origin: num_origin,
//                    num_compare: num_error,
//                    numberString_origin: numberString_origin,
//                    numberString_compare: numberString_error
//                )
//            )
//        }
    }
    
    private func debugMessage(
        from: String,
        to: String,
        origin_from: String,
        origin_to: String,
        num_from: NSNumber? = nil,
        num_to: NSNumber? = nil,
        numberString_from: String? = nil,
        numberString_to: String? = nil
    ) -> String {
        return """
        🧚🏻‍♀️ \(from) ⇢ \(to)

        * origin number string
        number_\(from) : \(origin_from)
        number_\(to) : \(origin_to)
        
        * to number
        number_\(from) : \(num_from?.stringValue ?? "nil")
        number_\(to) : \(num_to?.stringValue ?? "nil")

        * to localized number string
        number_\(from) : \(numberString_from ?? "nil")
        number_\(to) : \(numberString_to ?? "nil")
        """
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}


