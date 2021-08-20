//
//  ExpensesViewController.swift
//  PaidBills
//
//  Created by Ronaldo Gomes on 16/08/21.
//

import UIKit

protocol ExpensesViewControllerInput: AnyObject {
    func updateViewWith(list: [ExpenseViewModel], and totalExpensesValue: String)
}

class ExpensesViewController: UIViewController, ExpensesViewControllerInput {
    @IBOutlet weak var expenseTableView: UITableView!
    @IBOutlet weak var totalExpenseLabel: UILabel!
    
    private var interactor: ExpensesInteractorInput?
    private var router: ExpensesRouterLogic?
    
    private lazy var listOfExpenses: [ExpenseViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupWorkflow()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        interactor?.searchForExpensives()
    }
    
    @IBAction func addExpense(_ sender: UIBarButtonItem) {
        router?.addNewExpense()
    }
    
    private func setupWorkflow() {
        let presenter = ExpensesPresenter()
        presenter.controller = self
        let firebase = FirebaseWorker.shared
        let dataParser = ExpenseModelDataParser()
        interactor = ExpensesInteractor(presenter: presenter, firebaseWorker: firebase, dataParserWoker: dataParser)
        router = ExpensesRouter(controller: self)
    }
    
    private func configureTableView() {
        expenseTableView.delegate = self
        expenseTableView.dataSource = self
        
        expenseTableView.register(UINib.init(nibName: "ExpenseCell", bundle: nil), forCellReuseIdentifier: "ExpenseCell")
    }
    
    
    func updateViewWith(list: [ExpenseViewModel], and totalExpensesValue: String) {
        totalExpenseLabel.text = totalExpensesValue
        listOfExpenses = list
        expenseTableView.reloadData()
    }
}

extension ExpensesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfExpenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let expensive = listOfExpenses[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExpenseCell", for: indexPath) as? ExpenseCell else {
            fatalError("Not find table view")
        }
        
        cell.expenseDate.text = expensive.date
        cell.expenseName.text = expensive.name
        cell.expenseSituation.text = expensive.situation
        cell.expenseValue.text = expensive.value
        cell.refreshApperance()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.showExpense(with: listOfExpenses[indexPath.row], for: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            interactor?.removeExpense(indexPath.row)
            listOfExpenses.remove(at: indexPath.row)
            interactor?.searchForExpensives()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
