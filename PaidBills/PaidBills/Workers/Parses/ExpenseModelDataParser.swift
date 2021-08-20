//
//  ModelDataParser.swift
//  PaidBills
//
//  Created by Ronaldo Gomes on 18/08/21.
//

import Foundation
import Firebase

protocol DataParser {
    func convertModelExpenseToDictionary(_ model: ExpensesResponse) -> Dictionary<String, Any>
    func convertDictionaryToListOfExpensesResponse(_ listOfDictionary: [Dictionary<String, Any>]) -> [ExpensesResponse]
}

struct ExpenseModelDataParser: DataParser {
    func convertModelExpenseToDictionary(_ model: ExpensesResponse) -> Dictionary<String, Any> {
        return [
            "name": model.name,
            "value": model.value,
            "isPaid": model.isPaid,
            "date": model.date
        ]
    }
    
    func convertDictionaryToListOfExpensesResponse(_ listOfDictionary: [Dictionary<String, Any>]) -> [ExpensesResponse] {
        var listOfExpensesResponses = [ExpensesResponse]()
        
        listOfDictionary.forEach { expenseDictionary in
            guard let name = expenseDictionary["name"] as? String,
                  let value = expenseDictionary["value"] as? Double,
                  let isPaid = expenseDictionary["isPaid"] as? Bool,
                  let dateObject = expenseDictionary["date"] as? Timestamp else {
                listOfExpensesResponses = []
                return
            }

            let expense = ExpensesResponse(name: name, value: value, isPaid: isPaid, date: dateObject.dateValue())
            listOfExpensesResponses.append(expense)
        }
        
        return listOfExpensesResponses
    }
}
