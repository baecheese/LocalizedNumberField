//
//  TestNumberFormatter.swift
//  LocalizedNumberFieldTests
//
//  Created by 배지영 on 2021/02/15.
//

import XCTest
@testable import LocalizedNumberField

class TestNumberFormatter: XCTestCase {
    
    private let log = Logger(logPlace: LocalizedNumberFormatterTest.self)

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMatchingDiffrentIdentifier() throws {
        let numbers_en: [String] = [
            "123",
            "123.4",
            "123,456,789",
            "123,456,789.123"
        ]
        let numbers_ne: [String] = [
            "१२३",
            "१२३.४",
            "१२३,४५६,७८९",
            "१२३,४५६,७८९.१२३"
        ]
        let numbers_ur_IN: [String] = [
            "۱۲۳",
            "۱۲۳٫۴",
            "۱۲۳٬۴۵۶٬۷۸۹",
            "۱۲۳٬۴۵۶٬۷۸۹٫۱۲۳"
        ]
        let numbers_fr_FR: [String] = [
            "123",
            "123,4",
            "123 456 789",
            "123 456 789,123"
        ]
        let identifiers: [String] = ["en_US", "ne", "ur_IN", "fr_FR"]
        let numbersDictionary: [String: [String]] = [
            "en_US": numbers_en,
            "ne": numbers_ne,
            "ur_IN": numbers_ur_IN,
            "fr_FR": numbers_fr_FR
        ]
        for identifier in identifiers {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.locale = Locale(identifier: identifier)
            for (identifier_compare, numbers_compare) in numbersDictionary {
                // identifier가 다른 NumberString 테스트
                guard identifier != identifier_compare else { continue }
                let originNumbers = numbersDictionary[identifier]!
                let compareNumbers = numbers_compare
                for index in 0...originNumbers.count - 1 {
                    let origin = originNumbers[index]
                    let compare = compareNumbers[index]
                    let currentOriginNumber = numberFormatter.number(from: origin)
                    let currentCompareNumber = numberFormatter.number(from: compare)
                    guard nil != currentCompareNumber else {
                        // ⚠️ String -> NSNumber로 변환 실패 시 로그
                        log.error(
                            message:
                                debugMessage(
                                    originIdentifier: identifier,
                                    compareIdentifier: identifier_compare,
                                    origin: origin,
                                    compare: compare,
                                    num_origin: currentOriginNumber,
                                    num_compare: currentCompareNumber
                                )
                        )
                        continue
                    }
                    let localizedNumberString_origin = numberFormatter.string(from: currentOriginNumber!)
                    let localizedNumberString_compare = numberFormatter.string(from: currentCompareNumber!)
                    XCTAssertEqual(localizedNumberString_origin, localizedNumberString_compare)
                    log.info(
                        message:
                            debugMessage(
                                originIdentifier: identifier,
                                compareIdentifier: identifier_compare,
                                origin: origin,
                                compare: compare,
                                num_origin: currentOriginNumber,
                                num_compare: currentCompareNumber,
                                numberString_origin: localizedNumberString_origin,
                                numberString_compare: localizedNumberString_compare
                            )
                    )
                }
            }
        }
    }
    
    private func debugMessage(
        originIdentifier: String,
        compareIdentifier: String,
        origin: String,
        compare: String,
        num_origin: NSNumber? = nil,
        num_compare: NSNumber? = nil,
        numberString_origin: String? = nil,
        numberString_compare: String? = nil
    ) -> String {
        return """
        🧚🏻‍♀️ origin identifier : \(originIdentifier)
        🧚🏻‍♀️ compare identifier : \(compareIdentifier)

        * input number
        number_\(originIdentifier) : \(origin)
        number_\(compareIdentifier) : \(compare)
        
        * to number
        number_\(originIdentifier) : \(num_origin?.stringValue ?? "nil")
        number_\(compareIdentifier) : \(num_compare?.stringValue ?? "nil")

        * to localized number string (\(originIdentifier))
        number_\(originIdentifier) : \(numberString_origin ?? "nil")
        number_\(compareIdentifier) : \(numberString_compare ?? "nil")
        """
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
