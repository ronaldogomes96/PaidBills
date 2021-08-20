//
//  ExpensePresenter.swift
//  PaidBills
//
//  Created by Ronaldo Gomes on 18/08/21.
//

import Foundation

protocol ExpensePresenterInput {
    func savedExpenseSucess()
    func savedExpenseFailure()
}

class ExpensePresenter: ExpensePresenterInput {
    weak var controller: ExpenseViewControllerInput?
    
    func savedExpenseSucess() {
        controller?.expenseSaved()
    }
    
    func savedExpenseFailure() {
        controller?.expenseNotSaved()
    }
}
