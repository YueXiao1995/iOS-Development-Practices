//
//  ChecklistTableVIewCell.swift
//  CheckList
//
//  Created by YueXiao on 2019/5/26.
//  Copyright © 2019 yuexiao. All rights reserved.
//

import UIKit

class ChecklistTableViewCell: UITableViewCell {

    @IBOutlet weak var toDoTaskLabel: UILabel!
    @IBOutlet weak var checkMarkLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
