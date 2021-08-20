//
//  ExpenseInteractor.swift
//  PaidBills
//
//  Created by Ronaldo Gomes on 18/08/21.
//

import Foundation

protocol ExpenseInteractorInput {
    func saveExpense(with request: ExpenseRequest)
    func updateExpense(with request: ExpenseRequest, and index: Int)
}

class ExpenseInteractor: ExpenseInteractorInput {
    private var presenter: ExpensePresenterInput
    private var firebaseWorker: FirebaseServices
    private var dataParserWorker: DataParser
    
    init(presenter: ExpensePresenterInput,
         firebaseWorker: FirebaseServices,
         dataParserWorker: DataParser) {
        self.presenter = presenter
        self.firebaseWorker = firebaseWorker
        self.dataParserWorker = dataParserWorker
    }
    
    func saveExpense(with request: ExpenseRequest) {
        let dic = dataParserWorker.convertModelExpenseToDictionary(request)
        firebaseWorker.addNewExpense(dic) { result in
            switch result {
            case true:
                self.presenter.savedExpenseSucess()
            case false:
                self.presenter.savedExpenseFailure()
            }
        }
    }
    
    func updateExpense(with request: ExpenseRequest, and index: Int) {
        let dic = dataParserWorker.convertModelExpenseToDictionary(request)
        firebaseWorker.update(expense: dic, for: index) { result in
            switch result {
            case true:
                self.presenter.savedExpenseSucess()
            case false:
                self.presenter.savedExpenseFailure()
            }
        }
    }
}
