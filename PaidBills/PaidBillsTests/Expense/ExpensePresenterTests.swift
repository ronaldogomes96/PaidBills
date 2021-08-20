//
//  ExpensePresenterTests.swift
//  PaidBillsTests
//
//  Created by Ronaldo Gomes on 20/08/21.
//

import Foundation
import XCTest
@testable import PaidBills

class ExpensePresenterTests: XCTestCase {
    let controllerMock = ExpenseViewControllerInputMock()

    func test_savedExpenseSucess_shouldCallControllerWithSucess() {
        // Given
        let sut = ExpensePresenter()
        sut.controller = controllerMock
        
        // When
        sut.savedExpenseSucess()
        
        // Then
        XCTAssertTrue(controllerMock.isSavedExpenseCall)
    }
    
    func test_savedExpenseFailure_shouldCallControllerWithFailure() {
        // Given
        let sut = ExpensePresenter()
        sut.controller = controllerMock
        
        // When
        sut.savedExpenseFailure()
        
        // Then
        XCTAssertTrue(controllerMock.isExpenseFailureCall)
    }
}
