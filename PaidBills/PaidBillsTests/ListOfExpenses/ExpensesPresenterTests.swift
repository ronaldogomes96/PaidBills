//
//  ExpensesPresenterTests.swift
//  PaidBillsTests
//
//  Created by Ronaldo Gomes on 20/08/21.
//

import Foundation
import XCTest
@testable import PaidBills

class ExpensesPresenterTests: XCTestCase {
    let controllerMock = ExpensesViewControllerMock()
    
    func test_presentExpenses_noValues_shouldCallControllerWithEmptyValues() {
        // Given
        let sut = ExpensesPresenter()
        sut.controller = controllerMock
        
        // When
        sut.presentExpenses(with: [], and: 0.0)
        
        // Then
        XCTAssertTrue(controllerMock.controllerCall)
        XCTAssertTrue(controllerMock.listExpenses.isEmpty)
        XCTAssertEqual(controllerMock.totalExpensesValue, "R$ 0.0")
    }
    
    func test_presentExpenses_twoValues_shouldCallControllerWithTwoValues() {
        // Given
        let sut = ExpensesPresenter()
        sut.controller = controllerMock
        
        // When
        sut.presentExpenses(with: ExpenseResponseCreationHelper.returnsThreeExpensesResponse(), and: 50.0)
        
        // Then
        XCTAssertTrue(controllerMock.controllerCall)
        XCTAssertEqual(controllerMock.listExpenses.count, 3)
        XCTAssertEqual(controllerMock.totalExpensesValue, "R$ 50.0")
    }
}
