//
//  ExpensesPresenter.swift
//  PaidBills
//
//  Created by Ronaldo Gomes on 17/08/21.
//

import Foundation

protocol ExpensesPresenterInput {
    func presentExpenses(with response: [ExpensesResponse], and totalValueOfExpenses: Double)
}

class ExpensesPresenter: ExpensesPresenterInput {
    weak var controller: ExpensesViewControllerInput?
    
    func presentExpenses(with response: [ExpensesResponse], and totalValueOfExpenses: Double) {
        var listOfExpensesViewModel = [ExpenseViewModel]()
        
        response.forEach { expense in
            let expenseViewModel = ExpenseViewModel(value: "\(expense.value)",
                                                    name: expense.name,
                                                    date: expense.date.convertToString()!,
                                                    situation: "\(expense.isPaid)")
            listOfExpensesViewModel.append(expenseViewModel)
        }
        
        let totalValue = "R$ \(totalValueOfExpenses)"
        
        controller?.updateViewWith(list: listOfExpensesViewModel, and: totalValue)
    }
}
