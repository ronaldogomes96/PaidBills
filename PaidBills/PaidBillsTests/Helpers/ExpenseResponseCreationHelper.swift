//
//  ExpenseResponseCreationHelper.swift
//  PaidBillsTests
//
//  Created by Ronaldo Gomes on 20/08/21.
//

import Foundation
@testable import PaidBills

class ExpenseResponseCreationHelper {
    static func returnsThreeExpensesResponse() -> [ExpensesResponse] {
        return [
            ExpensesResponse(name: "Despesa1",
                             value: 10.0,
                             isPaid: false,
                             date: Date(timeIntervalSince1970: -123456789.0)),
            ExpensesResponse(name: "Despesa2",
                             value: 20.0,
                             isPaid: true,
                             date: Date(timeIntervalSince1970: -123456789.0)),
            ExpensesResponse(name: "Despesa3",
                             value: 20.0,
                             isPaid: false,
                             date: Date(timeIntervalSince1970: -123456789.0))
        ]
    }
}
