//
//  ExpenseModelDataParserTests.swift
//  PaidBillsTests
//
//  Created by Ronaldo Gomes on 20/08/21.
//

import Foundation
import Firebase
import XCTest
@testable import PaidBills

class ExpenseModelDataParserTests: XCTestCase {
    func test_convertModelExpenseToDictionary_validExpense_shouldBeEquals() {
        // Given
        let sut = ExpenseModelDataParser()
        let expenseResponse = ExpensesResponse(name: "Despesa",
                                               value: 10.0,
                                               isPaid: false,
                                               date: Date(timeIntervalSince1970: -123456789.0))
        
        // When
        let expenseDictionary = sut.convertModelExpenseToDictionary(expenseResponse)
        
        // Then
        XCTAssertEqual(expenseDictionary["name"] as? String, "Despesa")
        XCTAssertEqual(expenseDictionary["value"] as? Double, 10.0)
        XCTAssertEqual(expenseDictionary["isPaid"] as? Bool, false)
        XCTAssertEqual(expenseDictionary["date"] as? Date, Date(timeIntervalSince1970: -123456789.0))
    }
    
    func test_convertDictionaryToListOfExpensesResponse_dictionaryWithThreeExpenses_expensesCountShouldBeEquals() {
        // Given
        let sut = ExpenseModelDataParser()
        let listOfDic = DictionaryCreationHelper.getListOfDictionary()
        
        // When
        let convertToDictionary = sut.convertDictionaryToListOfExpensesResponse(listOfDic)
        
        // Then
        XCTAssertEqual(convertToDictionary.count, 3)
    }
    
    func test_convertDictionaryToListOfExpensesResponse_invalidDictionary_shouldReturnEmpty() {
        // Given
        let sut = ExpenseModelDataParser()
        let invalidDic = DictionaryCreationHelper.getListOfInvalidDictionary()
        
        // When
        let convertToDictionary = sut.convertDictionaryToListOfExpensesResponse(invalidDic)
        
        // Then
        XCTAssertTrue(convertToDictionary.isEmpty)
        
    }
}
