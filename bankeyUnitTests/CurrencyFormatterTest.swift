//
//  CurrencyFormatterTest.swift
//  bankeyUnitTests
//
//  Created by Irfan Dary on 19/03/24.
//

import Foundation
import XCTest

@testable import bankey

class Test: XCTestCase{
    var formatter: CurrencyFormatter!
    
    override func setUp()  {
         super.setUp()
        formatter = CurrencyFormatter()
    }
    
    func testBreakDollarsIntoCents() throws{
        let result = formatter.breakIntoDollarsAndCents(929466.23)
        XCTAssertEqual(result.0, "929466")
        XCTAssertEqual(result.1, "23")
    }
    // Challenge: You write
    func testDollarsFormatted() throws {
       
        let locale = Locale.current
        let symbol = locale.currencySymbol!
        let result = formatter.dollarsFormatted(929466.23)
        
        XCTAssertEqual(result.replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression), "\(symbol) 929.466")
    }

    // Challenge: You write
    func testZeroDollarsFormatted() throws {
        let locale = Locale.current
        let symbol = locale.currencySymbol!
        let result = formatter.dollarsFormatted(0.00)
        XCTAssertEqual(result.replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression), "\(symbol) 0")
    }
}

