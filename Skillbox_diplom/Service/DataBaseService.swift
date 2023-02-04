//
//  File.swift
//  Skillbox_diplom
//
//  Created by Aliaksandr Pustahvar on 20.01.23.
//

import UIKit
import CoreData

class DataBaseService {
    static let shared = DataBaseService()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func categories() -> [Category] {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        var fetchedCategories: [Category] = []
        
        do {
            fetchedCategories = try context.fetch(request)
        } catch {
            print("Error fetching categories")
        }
        return fetchedCategories
    }
    
    func expences(category: Category) -> [Expences] {
        let request: NSFetchRequest<Expences> = Expences.fetchRequest()
        request.predicate = NSPredicate(format: "(category = %@)", category)
        var fetchedExpences: [Expences] = []
        
        do {
            fetchedExpences = try context.fetch(request)
        } catch {
            print("Error fetching expences")
        }
        return fetchedExpences
        }
    
    func incomes() -> [Income] {
        let request: NSFetchRequest<Income> = Income.fetchRequest()
        var fetchedIncomes: [Income] = []
        
        do {
            fetchedIncomes = try context.fetch(request)
        } catch {
            print("Error fetching incomes")
        }
        return fetchedIncomes
    }
    
    func allExpences() -> [Expences] {
        let request: NSFetchRequest<Expences> = Expences.fetchRequest()
        var fetchedAllExpences: [Expences] = []
        
        do {
            fetchedAllExpences = try context.fetch(request)
        } catch {
            print("Error fetching categories")
        }
        return fetchedAllExpences
    }
    
    func currentAmount() -> Double {
        let expencesAmount = allExpences().reduce(0) { $0 + $1.amount} 
        let incomesAmount = incomes().reduce(0) { $0 + $1.amount }
        return incomesAmount - expencesAmount
    }
}
