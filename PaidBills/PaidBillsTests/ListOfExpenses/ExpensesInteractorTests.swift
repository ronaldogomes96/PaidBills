//
//  ExpensesInteractorTests.swift
//  PaidBillsTests
//
//  Created by Ronaldo Gomes on 20/08/21.
//

import Foundation
import XCTest
@testable import PaidBills

class ExpensesInteractorTests: XCTestCase {
    var presenterMock = ExpensesPresenterMock()
    var firebaseMock = FirebaseWorkerMock()
    var dataParser = ExpenseModelDataParser()
    
    func test_searchForExpensives_noExpenses_shouldCallPresenterWithEmptyValues() {
        // Given
        let sut = ExpensesInteractor(presenter: presenterMock,
                                     firebaseWorker: firebaseMock,
                                     dataParserWoker: dataParser)
        
        // When
        firebaseMock.isSucessCase = false
        sut.searchForExpensives()
        
        // Then
        XCTAssertTrue(presenterMock.presenterCall)
        XCTAssertTrue(presenterMock.response.isEmpty)
        XCTAssertEqual(presenterMock.totalValueOfExpenses, 0.0)
    }
    
    func test_searchForExpensives_threeExpenses_shouldCallPresenterWithValues() {
        // Given
        let sut = ExpensesInteractor(presenter: presenterMock,
                                     firebaseWorker: firebaseMock,
                                     dataParserWoker: dataParser)
        
        // When
        firebaseMock.isSucessCase = true
        sut.searchForExpensives()
        
        // Then
        XCTAssertTrue(presenterMock.presenterCall)
        XCTAssertEqual(presenterMock.response.count, 3)
        XCTAssertEqual(presenterMock.totalValueOfExpenses, 310.0)
    }
    
    
}
