//
//  RoleWorkingTableViewCell.swift
//  OneNight
//
//  Created by kento on 2016/02/20.
//  Copyright © 2016年 Kento Ohara. All rights reserved.
//

import UIKit

class RoleWorkingTableViewCell: UITableViewCell {
    
    @IBOutlet var myNumberLabel: UILabel!
    @IBOutlet var mytTextLabel: UILabel!
    @IBOutlet var myImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
