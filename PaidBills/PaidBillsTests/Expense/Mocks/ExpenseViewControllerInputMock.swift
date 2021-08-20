//
//  ExpenseViewControllerInputMock.swift
//  PaidBillsTests
//
//  Created by Ronaldo Gomes on 20/08/21.
//

import Foundation
@testable import PaidBills

class ExpenseViewControllerInputMock: ExpenseViewControllerInput {
    var isSavedExpenseCall = false
    var isExpenseFailureCall = false
    
    func expenseSaved() {
        isSavedExpenseCall = true
    }
    
    func expenseNotSaved() {
        isExpenseFailureCall = true
    }
}
