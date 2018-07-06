//
//  EntryCell.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-30.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import UIKit

class EntryCell: BaseCell {
    
    override func setUpViews() {
        super.setUpViews()
        
        backgroundColor = .white
        
        addSubview(titleLabel)
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        addSubview(iconImageView)
        iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 16.0).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 16.0).isActive = true
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.medium)
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
