//
//  ExpensesViewControllerInputMock.swift
//  PaidBillsTests
//
//  Created by Ronaldo Gomes on 20/08/21.
//

import Foundation
@testable import PaidBills

class ExpensesViewControllerMock: ExpensesViewControllerInput {
    var controllerCall = false
    var listExpenses = [ExpenseViewModel]()
    var totalExpensesValue = ""
    
    func updateViewWith(list: [ExpenseViewModel], and totalExpensesValue: String) {
        controllerCall = true
        listExpenses = list
        self.totalExpensesValue = totalExpensesValue
    }
}
