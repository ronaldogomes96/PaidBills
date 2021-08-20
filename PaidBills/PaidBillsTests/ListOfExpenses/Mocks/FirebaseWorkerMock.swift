//
//  FirebaseWorkerMock.swift
//  PaidBillsTests
//
//  Created by Ronaldo Gomes on 20/08/21.
//

import Foundation
@testable import PaidBills

class FirebaseWorkerMock: FirebaseServices {
    var isSucessCase = true
    
    func addNewExpense(_ model: Dictionary<String, Any>, completion: @escaping (Bool) -> Void) {
        if isSucessCase {
            completion(true)
        } else {
            completion(false)
        }
    }
    
    func readAllExpenses(completion: @escaping ([Dictionary<String, Any>]) -> Void) {
        if isSucessCase {
            completion(DictionaryCreationHelper.getListOfDictionary())
        } else {
            completion([])
        }
    }
    
    func update(expense: Dictionary<String, Any>, for index: Int, completion: @escaping (Bool) -> Void) {
        if isSucessCase {
            completion(true)
        } else {
            completion(false)
        }
    }
    
    func deleteExpense(with index: Int) {
        
    }
}
