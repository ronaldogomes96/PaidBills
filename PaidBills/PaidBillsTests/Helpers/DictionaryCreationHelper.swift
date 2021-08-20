//
//  DictionaryCreationHelper.swift
//  PaidBillsTests
//
//  Created by Ronaldo Gomes on 20/08/21.
//

import Foundation
import Firebase

class DictionaryCreationHelper {
    static func getListOfDictionary() -> [Dictionary<String, Any>] {
        return [
            [
                "name": "Despesa1",
                "value": 10.0,
                "isPaid": true,
                "date": Timestamp(date: Date(timeIntervalSince1970: -123456789.0))
            ],
            [
                "name": "Despesa2",
                "value": 50.0,
                "isPaid": false,
                "date": Timestamp(date: Date(timeIntervalSince1970: -123456789.0))
            ],
            [
                "name": "Despesa3",
                "value": 250.0,
                "isPaid": true,
                "date": Timestamp(date: Date(timeIntervalSince1970: -123456789.0))
            ]
        ]
    }
    
    static func getListOfInvalidDictionary() -> [Dictionary<String, Any>] {
        return [[
            "name": 1.0,
            "value": "Invalid",
            "isPaid": true,
            "date": Date(timeIntervalSince1970: -123456789.0)
        ]]
    }
}
