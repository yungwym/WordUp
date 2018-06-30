//
//  DFEntryCell.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-29.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import UIKit

class DFEntryCell: BaseCell {
    
    override func setUpViews() {
        super.setUpViews()
        
        backgroundColor = .white
        
        addSubview(dfLabel)
        dfLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dfLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        //        sarLabel.heightAnchor.constraint(equalToConstant: 53.25).isActive = true
        //        sarLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        dfLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0).isActive = true
        
        addSubview(iconImageView)
        iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 12.0).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 12.0).isActive = true
        iconImageView.trailingAnchor.constraint(equalTo: dfLabel.leadingAnchor, constant: -16.0).isActive = true
        
    }
    
    let dfLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Arrow")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
}
