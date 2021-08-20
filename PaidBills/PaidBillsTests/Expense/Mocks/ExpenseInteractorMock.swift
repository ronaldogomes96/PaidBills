//
//  ExpenseInteractorMock.swift
//  PaidBillsTests
//
//  Created by Ronaldo Gomes on 20/08/21.
//

import Foundation
@testable import PaidBills

class ExpensePresenterMock: ExpensePresenterInput {
    var isSavedExpenseCall = false
    var isExpenseFailureCall = false
    
    func savedExpenseSucess() {
        isSavedExpenseCall = true
    }
    
    func savedExpenseFailure() {
        isExpenseFailureCall = true
    }
}
