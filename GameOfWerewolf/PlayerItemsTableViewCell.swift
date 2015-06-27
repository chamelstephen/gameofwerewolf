//
//  PlayerItemsTableViewCell.swift
//  GameOfWerewolf
//
//  Created by kento on 2015/05/30.
//  Copyright (c) 2015年 Kento Ohara. All rights reserved.
//

import UIKit

class PlayerItemsTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var PlayerImageView: UIImageView!
    @IBOutlet weak var RowNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
