//
//  AddingViewController.swift
//  Skillbox_diplom
//
//  Created by Aliaksandr Pustahvar on 20.01.23.
//

import UIKit

class AddingViewController: UIViewController, UITextFieldDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    public var option: String = ""
    public var addUpdateCategories: (() -> Void)?
    public var addUpdateIncomes: (() -> Void)?
    
    @IBOutlet var titleTF: UITextField!
    @IBOutlet var saveButton: UIButton!
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func save(_ sender: Any) {
        if option == "category" {
            if let text = titleTF.text, !text.isEmpty {
                let newCategory = Category(context: self.context)
                newCategory.categoryName = text
                do {
                    try self.context.save()
                } catch {
                    print("Error new cateegory saving")
                }
            }
            addUpdateCategories?()
            self.dismiss(animated: true)
        }
        else if option == "amount" {
            if let text = titleTF.text, !text.isEmpty {
                let newAmount = Income(context: self.context)
                newAmount.amount = Double(text.replacingOccurrences(of: ",", with: ".")) ?? 0
                newAmount.date = .now
                do {
                    try self.context.save()
                } catch {
                    print("Error new amount saving")
                }
            }
            addUpdateIncomes?()
            self.dismiss(animated: true)
        }
        else { return }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTF.becomeFirstResponder()
        titleTF.delegate = self
        saveButton.setUp()
    }
}
