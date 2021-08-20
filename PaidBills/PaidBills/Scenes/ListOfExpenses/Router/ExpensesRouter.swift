//
//  ExpensesRouter.swift
//  PaidBills
//
//  Created by Ronaldo Gomes on 17/08/21.
//

import UIKit

protocol ExpensesRouterLogic {
    func addNewExpense()
    func showExpense(with model: ExpenseViewModel, for expenseIndex: Int)
}

class ExpensesRouter: ExpensesRouterLogic {
    weak var controller: ExpensesViewController?
    
    init(controller: ExpensesViewController) {
        self.controller = controller
    }
    
    func addNewExpense() {
        let vc = getExpenseController()
        controller?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showExpense(with model: ExpenseViewModel, for expenseIndex: Int) {
        let vc = getExpenseController()
        
        vc.name = model.name
        vc.value = model.value
        vc.date = model.date.convertToDate()!
        vc.paySlider = Bool(model.situation)!
        vc.expenseIndex = expenseIndex
        vc.isNewExpense = false
        
        controller?.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func getExpenseController() -> ExpenseViewController {
        let storyboard = UIStoryboard(name: "Expense", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "Expense") as! ExpenseViewController
    }
}
