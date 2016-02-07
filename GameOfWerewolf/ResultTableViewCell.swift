//
//  ResultTableViewCell.swift
//  OneNight
//
//  Created by kento on 2016/02/06.
//  Copyright © 2016年 Kento Ohara. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var diedImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        diedImageView?.image = UIImage(named: "punishview.png")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
