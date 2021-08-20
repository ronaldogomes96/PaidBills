//
//  ExpensesPresenterMock.swift
//  PaidBillsTests
//
//  Created by Ronaldo Gomes on 20/08/21.
//

import Foundation
@testable import PaidBills

class ExpensesPresenterMock: ExpensesPresenterInput {
    var presenterCall = false
    var response = [ExpensesResponse]()
    var totalValueOfExpenses = 0.0
    
    func presentExpenses(with response: [ExpensesResponse], and totalValueOfExpenses: Double) {
        presenterCall = true
        self.response = response
        self.totalValueOfExpenses = totalValueOfExpenses
    }
}
