//
//  ExpensesInteractor.swift
//  PaidBills
//
//  Created by Ronaldo Gomes on 17/08/21.
//

import Foundation

protocol ExpensesInteractorInput {
    func searchForExpensives()
    func removeExpense(_ index: Int)
}

class ExpensesInteractor: ExpensesInteractorInput {
    private var presenter: ExpensesPresenterInput
    private var firebaseWorker: FirebaseServices
    private var dataParserWorker: DataParser
    
    init(presenter: ExpensesPresenterInput,
         firebaseWorker: FirebaseServices,
         dataParserWoker: DataParser) {
        self.presenter = presenter
        self.firebaseWorker = firebaseWorker
        self.dataParserWorker = dataParserWoker
    }
    
    func searchForExpensives() {
        var listOfExpensive = [Dictionary<String, Any>]()
        var expensesValues = [Double]()
        firebaseWorker.readAllExpenses { expenses in
            expenses.forEach { expense in
                listOfExpensive.append(expense)
                expensesValues.append(expense["value"] as! Double)
            }
            
            let responses = self.dataParserWorker.convertDictionaryToListOfExpensesResponse(expenses)
            let expensesTotalValue = self.calculateTotalOfExpensesValues(expensesValues)
            self.presenter.presentExpenses(with: responses, and: expensesTotalValue)
        }
    }
    
    internal func calculateTotalOfExpensesValues(_ expenses: [Double]) -> Double {
        return expenses.reduce(0, {$0 + $1})
    }

    func removeExpense(_ index: Int) {
        firebaseWorker.deleteExpense(with: index)
    }
}
