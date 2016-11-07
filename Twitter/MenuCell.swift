//
//  MenuCell.swift
//  Twitter
//
//  Created by Neha Samant on 11/3/16.
//  Copyright © 2016 Neha Samant. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var menuTitle: UILabel!
    
    var menuItem: MenuItem! {
        didSet {
            menuTitle.text = menuItem.title
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
