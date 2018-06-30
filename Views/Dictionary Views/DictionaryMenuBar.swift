//
//  DictionaryMenuBar.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-28.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import UIKit

class DictionaryMenuBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let imageArry = ["DictionaryBarSmaller Copy","Group 2"]
    let dictCellID = "dictCellID"
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    var dictionaryVC : DictionaryVC?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        collectionView.register(DictMenuCell.self, forCellWithReuseIdentifier: dictCellID)
        
        let selectedIndexPath = NSIndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: [])
        
        setUpHorizontalBar()
    }
    
    func setUpHorizontalBar() {
      
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor(red: 71/255, green: 117/255, blue: 225/255, alpha: 1.0)
        horizontalBarView.layer.cornerRadius = 3.0
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(horizontalBarView)
        
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        
        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 4.0).isActive = true
        horizontalBarView.clipsToBounds = true
    }
    
    //CollectionView Setup
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.addSubview(cv)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        cv.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        cv.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        cv.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        cv.layer.cornerRadius = 3.0
        cv.layer.borderColor = UIColor(red: 71/255, green: 117/255, blue: 225/255, alpha: 1.0).cgColor
        cv.layer.borderWidth = 0.75
        cv.delegate = self
        cv.dataSource = self
        return cv
    } ()
    
    
    //CollectionView Delegate & Datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let dictCell = collectionView.dequeueReusableCell(withReuseIdentifier: dictCellID, for: indexPath) as! DictMenuCell
        
        dictCell.imageView.image = UIImage(named: imageArry[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        
        return dictCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: frame.width / 2, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        dictionaryVC?.scrollToMenuIndex(menuIndex: indexPath.item)
        
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//Cell Setup
class DictMenuCell: BaseCell {
    
    //Setup ImageView
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "Syn.")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor(red: 39/255, green: 73/255, blue: 151/255, alpha: 1.0)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override func setUpViews() {
        super.setUpViews()
        
        backgroundColor = UIColor.white
        
        addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    //Set Cell Highlighted and Selected Color
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ?  UIColor(red: 71/255, green: 117/255, blue: 225/255, alpha: 1.0) : UIColor(red: 39/255, green: 73/255, blue: 151/255, alpha: 1.0)
        }
    }
    
    override var isSelected: Bool {
        didSet{
            imageView.tintColor = isSelected ?  UIColor(red: 71/255, green: 117/255, blue: 225/255, alpha: 1.0) : UIColor(red: 39/255, green: 73/255, blue: 151/255, alpha: 1.0)
        }
    }
}


