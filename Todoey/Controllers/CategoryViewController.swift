//
//  CategoryViewController.swift
//  Todoey
//
//  Created by admin on 2/20/18.
//  Copyright © 2018 MVMA. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }

    
    //MARK: - TableView Datasource Methods
    
    //MARK: - TableView Delegate Methods
    
    //MARK: - Model Manipulation Methods
    
    
    /*
     Theres a tableview that has rows which in essence is what a table view is
     The rows represent arrays where we can store items
     The add button is to add more content  in this case categories to the tableview
     We need to be able to load/save the content on the phone when user swipes up and rids the app
     
     Unsure exactly the functionality this app calls for * to add categories to the tableview*
     
     - The save/load function is for CRUD which is important because CRUD is needed for persistent storage such as SQLite to store the data in our database
     
     Use Core Data and add new categories and show categories inside the TableView
     
     Set up datasource so that we can display all the categories that are in our persistent data...
          ** Do we already have categories in our persistent data?**
     
     Setting up a tableview controller that draws from CRUD
     
     How do you even start?
     
     first thing is item array or something similar... create categories which is an array for category objects... initialize an empty array...Category is from NSManaged objects? => Managed objects are held in memory ala Data Model
     
     2nd grab a reference to context we're using to CRUD which is the thing that's going to communcicate with persistant container... how to create a reference.... //need to look up singleton videos
     *Singletons restricts to initialization of a class to an object... useful when you only need one object for an activity (useful when exactly one object is needed to coordinate actions across a sytstem)
     
     
     3rd setup table view data source methods (datasource) table view number of rows section and we need to return the # of items in catgegories array
     Table view delegate method table view self for row index pathe; going to dequeue  a reuseable cell with an identifier at index path. THe indentifier is a string. Once created reusable cell...
     
    4th we gotta set cells text label.text propery set it = to categories and tap into the name property/attribute... property gets automatically generated because we created it as an attribute.. then return cell
     5th create new alert for button using initializer as titile with alert being style default
     create an action with title being add
     nake sure to addaction and set up text field then store a reference to the text field UITextField
     
     
    */
    
    var categories = [Category]()
    

    let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //reference context
    
    //Cell Stuff
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let item = categories[indexPath.row]
        
        cell.textLabel?.text = item.name
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    //MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Added Category!", message: "", preferredStyle: .alert)
        //her title was "Add New Category"
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //her title was "Add" this is the name of the button
            //inside this closure we specify what should happen if the user clicks the add button
            
            let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let newcategory = Category(context: self.context)
            
            newcategory.name = textField.text!
            
            self.categories.append(newcategory)
            
            self.saveCategories()
        
        }
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            //setting the textfield equal to the field in our alert
            textField.placeholder = "Add a new category"
        }
        
        present(alert, animated: true, completion: nil)
    }
    func saveCategories() {
        do {
            try context.save()
        } catch  {
            print("There is an error \(error).")
        }
            
        tableView.reloadData()
    }
    
    func loadCategories() {
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do{
        categories = try context.fetch(request)
        }catch{
            print("Error loading categoires \(error)")
            
        }
        tableView.reloadData()
    }


}










