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
    
    func testToLocalizedNumberString() throws {
        let formatter1 = LocalizedNumberFormatter(amount: "10000")
        XCTAssertEqual(try formatter1.toLocalizedNumber(numberStyle: .decimal), "10,000")
        log.info(message: try formatter1.toLocalizedNumber(numberStyle: .decimal))
        
        let formatter2 = LocalizedNumberFormatter(amount: "0.1")
        XCTAssertEqual(try formatter2.toLocalizedNumber(numberStyle: .decimal), "0.1")
        log.info(message: try formatter2.toLocalizedNumber(numberStyle: .decimal))
        
        let formatter3 = LocalizedNumberFormatter(amount: "0.0.1")
        do {
            let error = try formatter3.toLocalizedNumber(numberStyle: .decimal)
            XCTAssertThrowsError(error)
        } catch {
            log.error(message: error)
        }
        
        let formatter4 = LocalizedNumberFormatter(amount: "숫자아님1")
        do {
            let error = try formatter4.toLocalizedNumber(numberStyle: .decimal)
            XCTAssertThrowsError(error)
        } catch {
            log.error(message: error)
        }
        
        let formatter5 = LocalizedNumberFormatter(from: Locale.ko_KR, to: Locale.ko_KR, amount: "10000.674")
        XCTAssertEqual(try formatter5.toLocalizedNumber(numberStyle: .decimal), "10,000.674")
        log.info(message: try formatter5.toLocalizedNumber(numberStyle: .decimal))
        
        let formatter6 = LocalizedNumberFormatter(from: Locale.ko_KR, to: Locale(identifier: "fr_FR"), amount: "1,234.568")
        XCTAssertEqual(try formatter6.toLocalizedNumber(numberStyle: .decimal), "1 234,568")
        log.info(message: try formatter6.toLocalizedNumber(numberStyle: .decimal))
        
        let formatter7 = LocalizedNumberFormatter(from: Locale.ko_KR, to: Locale(identifier: "fr_FR"), amount: "10000.674")
        XCTAssertEqual(try formatter7.toLocalizedNumber(numberStyle: .decimal), "10 000,674")
        log.info(message: try formatter7.toLocalizedNumber(numberStyle: .decimal))
        
        
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
