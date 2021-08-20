//
//  DataFormaterToString.swift
//  PaidBills
//
//  Created by Ronaldo Gomes on 19/08/21.
//

import Foundation

extension String {
    func convertToDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        return formatter.date(from: self)
    }
}

extension Date {
    func convertToString() -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        return formatter.string(from: self)
    }
}
