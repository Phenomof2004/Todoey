//
//  ViewController.swift
//  Todoey
//
//  Created by admin on 2/13/18.
//  Copyright © 2018 MVMA. All rights reserved.
//

import UIKit
import RealmSwift


class ToDoListViewController: UITableViewController{
    
    var toDoItems : Results<Item>?
    
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
    
    }

   //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = toDoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done ? .checkmark : .none
            
        }else{
           cell.textLabel?.text = "No Items Added"
        }
        
        
        return cell
    }
    //MARK
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        if let item = toDoItems?[indexPath.row]{
            do{
                try realm.write {
                    //to delete in realm database
                    //realm.delete(item)
                    item.done = !item.done
                }
            }catch{
                print("Items had trouble saving \(error)")
            }
        }
        tableView.reloadData()
       // context.delete(itemArray[indexPath.row])
        //itemArray.remove(at: indexPath.row)
        
//        toDoItems?[indexPath.row].done = !toDoItems[indexPath.row].done
//
//        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    ///MARK
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
//            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            //AppDelegate is the class we need to get the object
            //So we tapped into UI application class, we're getting the shared singleton object which corresponds to the current app as an object and tapping into its delegate and casting it into the AppDelegate class and it works because they share the same UIApplicationDelegate inheritance
            //So now we have access to our AppDelegate as an object and tap into the persistent container and what not like in our AppDelegate class
            
            if let currentCategory = self.selectedCategory{
                do{
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                }catch{
                    print("Pissed off \(error)")
                }
            }
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }
//    func saveItems (item : Item){
//        do{
//        try realm.write {
//            realm.add(item)
//            }
//        }catch{
//            print("Items could not save \(error)")
//        }
//    }
//
//
//        do {
//
//           try context.save()
//            //transfers whats in our scratchpad to our data source aka saving
//        }catch{
//
//            print("Error sacving context \(error)")
//        }
//        self.tableView.reloadData()
//
//    }
    func loadItems(){
        toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        if let additionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
//
//        }else{
//            request.predicate = categoryPredicate
//        }
////        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate]))
////
////        request.predicate = compoundPredicate
////
//        do {
//        itemArray = try  context.fetch(request)
//        } catch {
//            print("Error fetching data\(error)")
//        }

        tableView.reloadData()
    }
    
}


extension ToDoListViewController: UISearchBarDelegate{
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
             toDoItems = toDoItems?.filter("title CONTAINS[cd] %a", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
       
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        let predicate  = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//         request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        loadItems(with: request, predicate: predicate)
            
            tableView.reloadData()
//
    }
//
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}























