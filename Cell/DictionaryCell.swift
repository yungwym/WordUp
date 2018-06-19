//
//  DictionaryCell.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-16.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import UIKit

class DictionaryCell: UITableViewCell {
    
    @IBOutlet weak var arrowImageView: UIImageView!    
    @IBOutlet weak var wordLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
