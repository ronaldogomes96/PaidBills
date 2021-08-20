//
//  ExpenseRouter.swift
//  PaidBills
//
//  Created by Ronaldo Gomes on 18/08/21.
//

import Foundation

protocol ExpenseRouterLogic {
    func backToListOfExpenses()
}

class ExpenseRouter: ExpenseRouterLogic {
    weak var controller: ExpenseViewController?
    
    init(controller: ExpenseViewController) {
        self.controller = controller
    }
    
    func backToListOfExpenses() {
        controller?.navigationController?.popViewController(animated: true)
    }
}
