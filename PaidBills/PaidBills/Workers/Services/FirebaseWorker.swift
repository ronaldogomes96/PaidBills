//
//  FIrebaseWorker.swift
//  PaidBills
//
//  Created by Ronaldo Gomes on 18/08/21.
//

import Foundation
import Firebase

protocol FirebaseServices {
    func addNewExpense(_ model: Dictionary<String, Any>, completion: @escaping (Bool) -> Void)
    func readAllExpenses(completion: @escaping([Dictionary<String, Any>]) -> Void)
    func update(expense: Dictionary<String, Any>,  for index: Int, completion: @escaping (Bool) -> Void)
    func deleteExpense(with index: Int)
}

class FirebaseWorker: FirebaseServices {
    let db = Firestore.firestore()
    private var ids = [String]()
    
    static let shared = FirebaseWorker()
    
    func addNewExpense(_ model: Dictionary<String, Any>, completion: @escaping (Bool) -> Void) {
        var ref: DocumentReference? = nil
        ref = db.collection("expenses").addDocument(data: model) { err in
            if let err = err {
                print("Error adding document: \(err)")
                completion(false)
            } else {
                print("Document added with ID: \(ref!.documentID)")
                completion(true)
            }
        }
    }
    
    func readAllExpenses(completion: @escaping([Dictionary<String, Any>]) -> Void) {
        ids = []
        
        return db.collection("expenses").order(by: "date").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let expensesDictionary = querySnapshot!.documents.map { expense -> Dictionary<String, Any> in
                    self.ids.append(expense.documentID)
                    return expense.data()
                }
                
                completion(expensesDictionary)
            }
        }
    }
    
    func update(expense: Dictionary<String, Any>,  for index: Int, completion: @escaping (Bool) -> Void) {
        return db.collection("expenses").document(ids[index]).setData(expense) { err in
            if let err = err {
                print("Error adding document: \(err)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    func deleteExpense(with index: Int) {
        db.collection("expenses").document(ids[index]).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
}
