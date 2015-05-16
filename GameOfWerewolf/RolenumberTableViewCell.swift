//
//  RolenumberTableViewCell.swift
//  GameOfWerewolf
//
//  Created by kento on 2015/05/16.
//  Copyright (c) 2015年 Kento Ohara. All rights reserved.
//

import UIKit

class RolenumberTableViewCell: UITableViewCell {

    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var workernumberlabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
