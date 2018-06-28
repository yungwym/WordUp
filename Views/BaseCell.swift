//
//  BaseCell.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-22.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import UIKit


class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    func setUpViews() {
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
