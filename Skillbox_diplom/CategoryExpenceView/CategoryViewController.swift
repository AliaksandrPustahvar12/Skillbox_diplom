//
//  CategoryViewController.swift
//  Skillbox_diplom
//
//  Created by Aliaksandr Pustahvar on 20.01.23.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate {
    var category = Category()
    var expences: [Expences] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet var graphButton: UIButton!
    @IBOutlet var expencesTableView: UITableView!
    @IBOutlet var addExpenceButton: UIButton!
    
    @IBAction func addNewExpence(_ sender: Any) {
        guard  let vc = storyboard?.instantiateViewController(withIdentifier: "AddExpenceVC") as? AddExpenceViewController
        else { return }
        vc.category = category
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        vc.addUpdateExpences = {[weak self] in
            self?.updateExpences()
        }
    }
    
    @IBAction func openGraph(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "CategoryGraphVC") as? CategoryGraphViewController
        else { return }
        vc.expences = expences
        navigationController?.pushViewController(vc, animated: true)
        vc.title = category.categoryName
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateExpences()
        expencesTableView.delegate = self
        expencesTableView.dataSource = self
        navigationItem.backButtonTitle = "Расходы"
        graphButton.setUp()
    }
    
    func updateExpences() {
        self.expences = DataBaseService.shared.expences(category: category)
        DispatchQueue.main.async {
            self.expencesTableView.reloadData()
        }
    }
}

extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expences.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExpencesVC") as? ExpencesTableViewCell
        else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "identifier")
            return cell
        }
        let expence = expences[indexPath.row]
        
        cell.titleLabel.text = expence.title
        cell.dateLabel.text = expence.date?.formatted(date: .abbreviated, time: .omitted)
        cell.amountLabel.text = expence.amount.asMoney
        cell.layer.cornerRadius = 8
        cell.layer.borderColor = UIColor.darkGreen?.cgColor
        cell.layer.borderWidth = 2
        return cell
    }
}
