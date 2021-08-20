//
//  ExpenseInteractorTests.swift
//  PaidBillsTests
//
//  Created by Ronaldo Gomes on 20/08/21.
//

import Foundation
import XCTest
@testable import PaidBills

class ExpenseInteractorTests: XCTestCase {
    var presenterMock = ExpensePresenterMock()
    var firebaseMock = FirebaseWorkerMock()
    var dataParser = ExpenseModelDataParser()
    
    func test_saveExpense_validRequest_shouldCallSavedPresenter() {
        // Given
        let sut = ExpenseInteractor(presenter: presenterMock,
                                    firebaseWorker: firebaseMock,
                                    dataParserWorker: dataParser)
        
        // When
        firebaseMock.isSucessCase = true
        sut.saveExpense(with: ExpenseResponseCreationHelper.returnsThreeExpensesResponse().first!)
        
        // Then
        XCTAssertTrue(presenterMock.isSavedExpenseCall)
    }
    
    func test_saveExpense_invalidFirebase_shouldCallFailurePresenter() {
        // Given
        let sut = ExpenseInteractor(presenter: presenterMock,
                                    firebaseWorker: firebaseMock,
                                    dataParserWorker: dataParser)
        
        // When
        firebaseMock.isSucessCase = false
        sut.saveExpense(with: ExpenseResponseCreationHelper.returnsThreeExpensesResponse().first!)
        
        // Then
        XCTAssertFalse(presenterMock.isSavedExpenseCall)
    }
    
    func test_updateExpense_validRequest_shouldCallSavedPresenter() {
        // Given
        let sut = ExpenseInteractor(presenter: presenterMock,
                                    firebaseWorker: firebaseMock,
                                    dataParserWorker: dataParser)
        
        // When
        firebaseMock.isSucessCase = true
        sut.updateExpense(with: ExpenseResponseCreationHelper.returnsThreeExpensesResponse().first!, and: 1)
        
        // Then
        XCTAssertTrue(presenterMock.isSavedExpenseCall)
    }
    
    func test_updateExpense_invalidFirebase_shouldCallFailurePresenter() {
        // Given
        let sut = ExpenseInteractor(presenter: presenterMock,
                                    firebaseWorker: firebaseMock,
                                    dataParserWorker: dataParser)
        
        // When
        firebaseMock.isSucessCase = false
        sut.updateExpense(with: ExpenseResponseCreationHelper.returnsThreeExpensesResponse().first!, and: 1)
        
        // Then
        XCTAssertFalse(presenterMock.isSavedExpenseCall)
    }
}
