//
//  ItemDetailViewController.swift
//  CheckList
//
//  Created by YueXiao on 2019/4/10.
//  Copyright © 2019 yuexiao. All rights reserved.
//

import UIKit

// this protocol only can be implement in class
protocol  ItemDetailViewControllerDelegate: class {
    // cancle add
    func itemDetailViewControllerDidCanale(_ controller: ItemDetailViewController)
    // add item
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem)
}


class ItemDetailViewController: UITableViewController {
    // 这里的delegate代指的是实现了itemDetailViewControllerDelegate这个protocol的实例，在本程序中，也就是checklistViewController
    weak var delegate: ItemDetailViewControllerDelegate?
    
    weak var todoList: ToDoList?
    
    weak var itemToEdit: ChecklistItem?

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    
    @IBOutlet weak var cancleBarbutton: UIBarButtonItem!
    
    // cancle
    @IBAction func cancle(_ sender: Any) {
        //navigationController?.popViewController(animated: true) // return to checklist page
        delegate?.itemDetailViewControllerDidCanale(self)
    }
    
    // add one item
    @IBAction func done(_ sender: Any) {
        //navigationController?.popViewController(animated: true) // return to checklist page
        if let item = itemToEdit, let text = textField.text{ // editing model,  get the text
            item.text = text // change the text of checklist item which is been editing
            delegate?.itemDetailViewController(self, didFinishEditing: item)// editing the checklist tableview
            
        } else { // adding model,
            if let item = todoList?.newToDo(){ // create a new checklist item
                if let textFieldText = textField.text {
                    item.text = textFieldText //set the text of new checklist item
                }
                item.checked = false // set the inti check mark
                // 这里的delegate，其实在运行时代指的是实现了itemDetailViewControllerDelegate这个protocol的实例，在本程序中，也就是checklistViewController
                delegate?.itemDetailViewController(self, didFinishAdding: item)
            }
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = itemToEdit{ //check if the itemToEdit is empty, id not, change the title and textField and other things
            title = "Edit Item"
            textField.text = item.text
            addBarButton.isEnabled = true
        }
        navigationItem.largeTitleDisplayMode = .never
        textField.delegate = self
    }
    
    // make the cell can not be selected
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    // make the textfield responed first, which means the user don't need to tap the text field
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
}

// make the keyboard disappear after tap the done button
extension ItemDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    // check if there is any text
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // ???????
        guard let oldText = textField.text,
            let stringRange = Range(range, in: oldText) else {
            return false
        }
        // get the actual text
        let newText = oldText.replacingCharacters(in: stringRange, with: string) // ?????????
        // check if the text is empty
        if newText.isEmpty {
            addBarButton.isEnabled = false  // disable the Add button
        } else {
            addBarButton.isEnabled = true   // enable the Add button
        }
        return true
    }
}
