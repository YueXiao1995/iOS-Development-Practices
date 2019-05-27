//
//  ToDoList.swift
//  CheckList
//
//  Created by YueXiao on 2019/4/10.
//  Copyright © 2019 yuexiao. All rights reserved.
//

import Foundation

class ToDoList {
    
    // add priority to items
    enum Priority: Int, CaseIterable {
        case high, medium, low, no
    }
    //var todos: [ChecklistItem] = []
    private var highPriorityTodos: [ChecklistItem] = []
    private var mediumPriorityTodos: [ChecklistItem] = []
    private var lowPriorityTodos: [ChecklistItem] = []
    private var noPriorityTodos: [ChecklistItem] = []
    
    init() {
        let row0Item = ChecklistItem()
        let row1Item = ChecklistItem()
        let row2Item = ChecklistItem()
        let row3Item = ChecklistItem()
        let row4Item = ChecklistItem()
        let row5Item = ChecklistItem()
        let row6Item = ChecklistItem()
        let row7Item = ChecklistItem()
        let row8Item = ChecklistItem()
        let row9Item = ChecklistItem()
        row0Item.text = "Take a jog"
        row1Item.text = "watch a movie"
        row2Item.text = "Code an app"
        row3Item.text = "walk the dog"
        row4Item.text = "study design pattern"
        row5Item.text = "Read a book"
        row6Item.text = "Play football"
        row7Item.text = "Listen music"
        row8Item.text = "Play computer game"
        row9Item.text = "Clen my room"
        addTodo(row0Item, for: .medium)
        addTodo(row1Item, for: .low)
        addTodo(row2Item, for: .high)
        addTodo(row3Item, for: .medium)
        addTodo(row4Item, for: .no)
        addTodo(row5Item, for: .medium)
        addTodo(row6Item, for: .low)
        addTodo(row7Item, for: .high)
        addTodo(row8Item, for: .medium)
        addTodo(row9Item, for: .no)
    }
    
    // create a new checklist item
    func newToDo() -> ChecklistItem {
        let item = ChecklistItem()
        item.text = randomTitle()
        item.checked = true
        mediumPriorityTodos.append(item)
        //todos.append(item)
        return item
    }
    
    func move(item: ChecklistItem, from sourcePriority: Priority, at sourceIndex: Int, to destinationPriority: Priority, at destinationIndex: Int){
        remove(item, from: sourcePriority, at: sourceIndex)
        addTodo(item, for: destinationPriority, at: destinationIndex)
        
        
    }
    
    // remove the item from different priorities array
    func remove(_ item: ChecklistItem, from priority: Priority, at index: Int){
        switch priority {
        case .high:
            highPriorityTodos.remove(at: index)
        case .medium:
            mediumPriorityTodos.remove(at: index)
        case .low:
            lowPriorityTodos.remove(at: index)
        case .no:
            noPriorityTodos.remove(at: index)
        }
    }
    
    // find the todolist by priority
    func todoList(for priority: Priority) -> [ChecklistItem] {
        switch priority {
        case .high:
            return highPriorityTodos
        case .medium:
            return mediumPriorityTodos
        case .low:
            return lowPriorityTodos
        case .no:
            return noPriorityTodos
        }
    }
    
    // save new item based on it's priority
    func addTodo(_ item: ChecklistItem, for priority: Priority, at index: Int = -1){
        switch priority {
        case .high:
            if index < 0 { // if index is default value
                highPriorityTodos.append(item) // add the item to the end of array
            } else {
                highPriorityTodos.insert(item, at: index) // insert the item to the array
            }
        case .medium:
            if index < 0 {
                mediumPriorityTodos.append(item)
            } else {
                mediumPriorityTodos.insert(item, at: index)
            }
        case .low:
            if index < 0 {
                lowPriorityTodos.append(item)
            } else {
                lowPriorityTodos.insert(item, at: index)
            }
        case .no:
            if index < 0 {
                noPriorityTodos.append(item)
            } else {
                noPriorityTodos.insert(item, at: index)
            }
        }
    }
    
    /*
    func remove(items: [ChecklistItem]){ // take a ChecklistItem array as a parameter
        for item in items {
            if let index = todos.index(of: item){  // for each item, find the location of it
                todos.remove(at: index) // remove it by using the location
            }
        }
    }
    */
    private func randomTitle() -> String {
        let titles = ["1", "2", "3", "4", "5"]
        let randomNumber = Int.random(in: 0 ... titles.count-1)
        return titles[randomNumber]
    }
    
    
    
}
