//
//  ExpenseCell.swift
//  PaidBills
//
//  Created by Ronaldo Gomes on 16/08/21.
//

import UIKit

class ExpenseCell: UITableViewCell {
    @IBOutlet weak var expenseName: UILabel!
    @IBOutlet weak var expenseDate: UILabel!
    @IBOutlet weak var expenseSituation: UILabel!
    @IBOutlet weak var expenseValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func refreshApperance() {
        if expenseSituation.text == "true" {
            expenseSituation.text = "Pago"
            expenseSituation.textColor = .systemGreen
        } else {
            expenseSituation.text = "Não pago"
            expenseSituation.textColor = .systemRed
        }
        
        expenseValue.text = "R$ \(expenseValue.text!)"
    }
}
