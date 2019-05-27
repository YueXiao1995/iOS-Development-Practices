//
//  ChecklistItem.swift
//  CheckList
//
//  Created by YueXiao on 2019/4/9.
//  Copyright © 2019 yuexiao. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject {
    @objc var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
}
