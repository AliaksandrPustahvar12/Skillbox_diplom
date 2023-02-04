//
//  HeadViewController.swift
//  Skillbox_diplom
//
//  Created by Aliaksandr Pustahvar on 19.01.23.
//

import UIKit

class HeadViewController: UIViewController, UITableViewDelegate {
    
    var categories: [Category] = []
    var incomes: [Income] = []
    var expences: [Expences] = []
    var currentBallance: Double = 0
    
    @IBOutlet var amountLabel: UILabel!
    
    @IBAction func addAmount(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "AddingVC") as? AddingViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        vc.saveButton.titleLabel?.text = "Дадаць даход"
        vc.titleTF.attributedPlaceholder = NSAttributedString(string: "Увядзіце суму", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGreen ?? .systemGray3])
        vc.titleTF.keyboardType = .decimalPad
        vc.option = "amount"
        vc.addUpdateIncomes = {[weak self] in
            self?.updateIncomes()
        }
    }
    
    @IBAction func addCategory(_ sender: Any) {
      guard  let vc = storyboard?.instantiateViewController(withIdentifier: "AddingVC") as? AddingViewController
         else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        vc.saveButton.titleLabel?.text = "Дадаць катэгорыю"
        vc.titleTF.attributedPlaceholder = NSAttributedString(string: "Увядзіце назву катэгорыі", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGreen ?? .systemGray3])
        vc.option = "category"
        vc.addUpdateCategories = {[weak self] in
            self?.updateCategories()
        }
    }
    
    @IBOutlet var addCategoryButton: UIButton!
    @IBOutlet var addIncomeButton: UIButton!
    @IBOutlet var openGraphButton: UIButton!
    @IBOutlet var categoriesTableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
 
    @IBAction func openGraph(_ sender: Any) {
    guard let vc = storyboard?.instantiateViewController(withIdentifier: "DoubleGraphVC") as? DoubleGraphViewController
        else { return }
        vc.expences = expences
        vc.incomes = incomes
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesTableView.dataSource = self
        categoriesTableView.delegate = self
        updateCurrentBallance()
        updateCategories()
        updateIncomes()
        updateExpences()
        navigationItem.backButtonTitle = "Назад"
        setupButtons()
      
    }
    override func viewWillAppear(_ animated: Bool) {
        updateCurrentBallance()
        updateExpences()
    }
    
    func updateCategories() {
        self.categories = DataBaseService.shared.categories()
            DispatchQueue.main.async {
                self.categoriesTableView.reloadData()
            }
    }
    
    func updateIncomes() {
        self.incomes = DataBaseService.shared.incomes()
    }
    
    func updateExpences() {
        self.expences = DataBaseService.shared.allExpences()
    }
    
   public func updateCurrentBallance() {
        self.currentBallance = DataBaseService.shared.currentAmount()
        DispatchQueue.main.async {
            self.amountLabel.text = "Бягучы баланс:   \(self.currentBallance.asMoney)"
        }
    }
    
}

extension HeadViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as? CategoryTableViewCell
        else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "identifier")
            return cell
        }
        let category = categories[indexPath.row]
        cell.categoryLabel.text = category.categoryName
        cell.layer.cornerRadius = 8
        cell.layer.borderColor = UIColor.darkGreen?.cgColor
        cell.layer.borderWidth = 2
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let category = categories[indexPath.row]
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "CategoryVC") as? CategoryViewController else { return }
        vc.title = category.categoryName
        vc.category = category
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupButtons() {
        let buttons = [openGraphButton, addCategoryButton, addIncomeButton]
        for button in buttons {
            button?.setUp()
        }
    }
}
