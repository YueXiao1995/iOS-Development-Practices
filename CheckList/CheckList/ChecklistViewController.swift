//
//  ViewController.swift
//  CheckList
//
//  Created by YueXiao on 2019/4/4.
//  Copyright © 2019 yuexiao. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    var todolist: ToDoList
    //var tableDate: [[ChecklistItem?]?]!
    
    // case a number to priority
    private func priorityForSectionIndex(_ index: Int) -> ToDoList.Priority? {
        return ToDoList.Priority(rawValue: index)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true //make the title big
        navigationItem.leftBarButtonItem = editButtonItem // set the edit button in the top bar
        tableView.allowsMultipleSelectionDuringEditing = true // enable the multiple selection under the editing model
        /*let sectionTitleCount = UILocalizedIndexedCollation.current().sectionTitles.count
        var allSections = [[ChecklistItem?]?](repeating: nil, count: sectionTitleCount) // init array, create 26 individual sections
        var sectionNumber = 0
        let collation = UILocalizedIndexedCollation.current()
        for item in todolist.todos{
            sectionNumber = collation.section(for: item, collationStringSelector: #selector(getter:ChecklistItem.text))  // get the section number
            if allSections[sectionNumber] == nil {  // if the section is not exist, create one
                allSections[sectionNumber] = [ChecklistItem?]()
            }
            allSections[sectionNumber]!.append(item) // add the item in the section
        }
        tableDate = allSections
        */
    }
    
    required init?(coder aDecoder: NSCoder) {
        todolist = ToDoList()
        super.init(coder: aDecoder)
    }
    
    // open the editing model of TableView
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        tableView.setEditing(tableView.isEditing, animated: true) // open the editing model
    }
    
    // how many cells will be display
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return tableDate[section] == nil ? 0 : tableDate[section]!.count// if nil, return 0, or return the number of items in this section
        if let priority = priorityForSectionIndex(section){
            return todolist.todoList(for: priority).count
        }
        return 0
    }
    
    
    // set the content of cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        //let item = todolist.todos[indexPath.row]
        if let priority = priorityForSectionIndex(indexPath.section){
            let items = todolist.todoList(for: priority)
            let item = items[indexPath.row]
            configureText(for: cell, with: item)
            configureCheckmark(for: cell, with: item)
        }
        return  cell
    }
    
    // delete a cell
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if let priority = priorityForSectionIndex(indexPath.section){
            let item = todolist.todoList(for: priority)[indexPath.row] // get the item from checklist item array
            todolist.remove(item, from: priority, at: indexPath.row) //remove the item from todolist
            let indexPaths = [indexPath]
            tableView.deleteRows(at: indexPaths, with: .automatic) // delete the cell view from tableview
        }
    }
    
    // set the action when the cell is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing { // check is the tableView is under editing model
            return
        }
        if let cell = tableView.cellForRow(at: indexPath) {
            if let priority = priorityForSectionIndex(indexPath.section){
                let items = todolist.todoList(for: priority)
                let item = items[indexPath.row]
                item.toggleChecked() // change the state of check mark
                configureCheckmark(for: cell, with: item) // change the state of the check mark
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
    
    // move the items
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //todolist.move(item: todolist.todos[sourceIndexPath.row], to: destinationIndexPath.row)
        if let sourcePriority = priorityForSectionIndex(sourceIndexPath.section),
            let destinationPriority = priorityForSectionIndex(destinationIndexPath.section) {
            let item = todolist.todoList(for: sourcePriority)[sourceIndexPath.row]
            todolist.move(item: item, from: sourcePriority, at: sourceIndexPath.row, to: destinationPriority, at: destinationIndexPath.row)
        }
        tableView.reloadData()
    }
    // set the number of section
    override func numberOfSections(in tableView: UITableView) -> Int {
        return ToDoList.Priority.allCases.count
    }
    /*
    // set the titles of sections
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return UILocalizedIndexedCollation.current().sectionTitles
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return UILocalizedIndexedCollation.current().section(forSectionIndexTitle: index)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return UILocalizedIndexedCollation.current().sectionTitles[section]
    }
    */
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        print("Add item")
        let newRowIndex = todolist.todoList(for: .medium).count
        //let newRowIndex = todolist.todos.count // to add the new item at the end of list
        _ = todolist.newToDo() // create a new checklist item, "_" means this instance is not going to be use
        let indexPath = IndexPath(row: newRowIndex, section: 0) // create a index path
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    
    // delete multiple rows
    @IBAction func deleteItems(_ sender: Any) {
        if let selectRows = tableView.indexPathsForSelectedRows { // get indexPaths of the the rows selected under editing model
            // (a) update the model
            //var items = [ChecklistItem] () // init an empty ChecklistItem array, it will be used as the parameter of the TToDoList's delete method
            for indexPath in selectRows {
                if let priority = priorityForSectionIndex(indexPath.section) { // cast the section address to priority
                    let todos = todolist.todoList(for: priority) // find the todos array by the priority
                    let rowToDelete = indexPath.row > todos.count - 1 ? todos.count - 1 : indexPath.row
                    let item = todos[rowToDelete]  // get the item from the array
                    todolist.remove(item, from: priority, at: rowToDelete)
                }
                //items.append(todolist.todos[indexPath.row]) // save the selected items into the new empty array
            }
            //todolist.remove(items: items) // delete the items
            // (b) update the table view
            tableView.beginUpdates()  //Begins a series of method calls
            tableView.deleteRows(at: selectRows, with: .automatic) // delete the selected cells
            tableView.endUpdates()
        }
    }
    
    
    // display the check mark
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
        guard let checkmarkCell = cell as? ChecklistTableViewCell else {
            return
        }
        if item.checked {
            checkmarkCell.checkMarkLabel.text = "√"
        } else {
            checkmarkCell.checkMarkLabel.text = ""
        }
    }
    
    // display the items in cells
    func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
        if let checkmarkCell = cell as? ChecklistTableViewCell{ // get the cell
            checkmarkCell.toDoTaskLabel.text = item.text //set the text of label which is inside the cell
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //find the specific segue
        if segue.identifier == "AddItemSegue" {
            //get the AdditemTableViewController through the segue
            if let itemDetailViewController = segue.destination as? ItemDetailViewController{
                 // 使AddItemTableViewController中的delegate等于这个ChecklistViewController
                itemDetailViewController.delegate = self
                itemDetailViewController.todoList = todolist
            }
        } else if segue.identifier == "EditItemSegue" {
            if let itemDetailViewController = segue.destination as? ItemDetailViewController{
                // 使AddItemTableViewController中的delegate等于这个ChecklistViewController
                if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell), let priority = priorityForSectionIndex(indexPath.section){ // get the position of the cell
                    let item = todolist.todoList(for: priority)[indexPath.row] // get the checklist item in this cell
                    itemDetailViewController.itemToEdit = item  // set the itemToEdit in AddItemTableViewController
                    itemDetailViewController.delegate = self
                }
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String? = nil
        if let priority = priorityForSectionIndex(section){
            switch priority {
            case .high:
                title = "High Priority Todos"
            case .medium:
                title = "Medium Priority Todos"
            case .low:
                title = "Low Priority Todos"
            case .no:
                title = "Someday Todos"
            }
        }
        return title
    }
}


// implement the protocol
extension ChecklistViewController: ItemDetailViewControllerDelegate{
    func itemDetailViewControllerDidCanale(_ controller: ItemDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    // update the table view after adding
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem) {
        navigationController?.popViewController(animated: true)
        let rowIndex = todolist.todoList(for: .medium).count-1 // the position of new item
        //todolist.todos.append(item)
        let indexPath = IndexPath(row: rowIndex, section: ToDoList.Priority.medium.rawValue)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    // update the table view after editing
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem) {
        for priority in ToDoList.Priority.allCases { // for each priority
            let currentist = todolist.todoList(for: priority)// get the list
            if let index = currentist.index(of: item) {// get the index of item
                let indexPath = IndexPath(row: index, section: priority.rawValue) // generate the indexPath for the item
                if let cell = tableView.cellForRow(at: indexPath){// get the cell
                     configureText(for: cell, with: item)  // update the cell
                }
            }
        }
        navigationController?.popViewController(animated: true)
    }
}

