//
//  StringsDateConvertsTests.swift
//  PaidBillsTests
//
//  Created by Ronaldo Gomes on 20/08/21.
//

import Foundation
import XCTest
@testable import PaidBills

class StringsDateConvertsTests: XCTestCase {

    func test_stringConvertToDate_valueString_notNil() {
        // When
        let convertToDate = "20/08/2021".convertToDate()
        
        // Then
        XCTAssertNotNil(convertToDate)
    }
    
    func test_stringConvertToDate_invalidStrign_shouldBeNil() {
        // When
        let convertToDate = "Not a date".convertToDate()
        
        // Then
        XCTAssertNil(convertToDate)
    }
    
    func test_dateConvertToString_valueDate_notNil() {
        // Given
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        // When
        let convertToString = formatter.date(from: "20/08/2021")!.convertToString()
        
        // Then
        XCTAssertNotNil(convertToString)
    }
}
