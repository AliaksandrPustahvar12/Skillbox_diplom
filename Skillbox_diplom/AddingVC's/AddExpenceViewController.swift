//
//  AddExpenceViewController.swift
//  Skillbox_diplom
//
//  Created by Aliaksandr Pustahvar on 21.01.23.
//

import UIKit

class AddExpenceViewController: UIViewController, UITextFieldDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    public var addUpdateExpences: (() -> Void)?
    var category = Category()
    @IBOutlet var titleTF: UITextField!
    @IBOutlet var amountTF: UITextField!
    @IBOutlet var saveButton: UIButton!
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func addNewExpence(_ sender: Any) {
        if let text = titleTF.text, !text.isEmpty {
            if let amount = amountTF.text, !amount.isEmpty{
                let newExpence = Expences(context: self.context)
                newExpence.title = text
                newExpence.amount = Double(amount.replacingOccurrences(of: ",", with: ".")) ?? 0
                newExpence.date = .now
                newExpence.category = category
                do {
                    try self.context.save()
                } catch {
                    print("Error expence saving")
                }
            }
        }
        addUpdateExpences?()
        self.dismiss(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTF.becomeFirstResponder()
        titleTF.delegate = self
        titleTF.attributedPlaceholder = NSAttributedString(string: "Увядзіце назву", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGreen ?? .systemGray3])
        amountTF.attributedPlaceholder = NSAttributedString(string: "Увядзіце суму", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGreen ?? .systemGray3])
        saveButton.setUp()
    }
}
