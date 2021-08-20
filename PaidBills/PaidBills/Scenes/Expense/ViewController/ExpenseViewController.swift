//
//  ExpenseViewController.swift
//  PaidBills
//
//  Created by Ronaldo Gomes on 18/08/21.
//

import UIKit

typealias ExpenseRequest = ExpensesResponse

protocol ExpenseViewControllerInput: AnyObject {
    func expenseSaved()
    func expenseNotSaved()
}

class ExpenseViewController: UIViewController, ExpenseViewControllerInput {
    @IBOutlet weak var expenseName: UITextField!
    @IBOutlet weak var expenseValue: UITextField!
    @IBOutlet weak var expenseDate: UIDatePicker!
    @IBOutlet weak var isPaySlider: UISwitch!
    
    var name: String?
    var value: String?
    var date: Date?
    var paySlider: Bool?
    var isNewExpense = true
    var expenseIndex = 0
    
    private var interactor: ExpenseInteractorInput?
    private var router: ExpenseRouterLogic?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWorkflow()
        
        if !isNewExpense {
            expenseName.text = name
            expenseValue.text = value
            expenseDate.date = date!
            isPaySlider.isOn = paySlider!
        }
    }
    
    private func setupWorkflow() {
        let presenter = ExpensePresenter()
        presenter.controller = self
        let firebase = FirebaseWorker.shared
        let dataParser = ExpenseModelDataParser()
        interactor = ExpenseInteractor(presenter: presenter, firebaseWorker: firebase, dataParserWorker: dataParser)
        router = ExpenseRouter(controller: self)
    }
    
    @IBAction func saveExpense(_ sender: UIBarButtonItem) {
        if isFieldsComplete() {
            let formatter = NumberFormatter()
            formatter.locale = Locale(identifier: "pt_BR")
            
            guard let name = expenseName.text,
                  let value = expenseValue.text else {
                showAlert()
                return
            }
            
            let request = ExpenseRequest(name: name, value: NSString(string: value).doubleValue, isPaid: isPaySlider.isOn, date: expenseDate.date)
            isNewExpense ? interactor?.saveExpense(with: request) : interactor?.updateExpense(with: request, and: expenseIndex)
        } else {
            showAlert()
        }
    }
    
    private func isFieldsComplete() -> Bool {
        return !(expenseName.text?.isEmpty ?? true && expenseValue.text?.isEmpty ?? true)
    }
    
    func expenseSaved() {
        router?.backToListOfExpenses()
    }
    
    func expenseNotSaved() {
        showAlert()
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Error", message: "Ocorreu um erro. Tente novamete", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
