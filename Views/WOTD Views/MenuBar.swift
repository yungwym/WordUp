//
//  MenuBar.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-21.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: Variables
    let cellId = "cellID"
    let imageArray = ["Syn. 16","Ant. 16","Rhy. 16"]
    
    let titleArray = ["Synonyms","Antonyms","Rhymes"]
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    
    var wotdController: WOTDVC?
    
    
    //MARK: Load View
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        //Register Cell to CollectionView
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        
        //Set Selected Index
        let selectedIndexPath = NSIndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: [])
        
        setupHorizontalBar()
        
    }

    //Horizontal Bar Setup
    func setupHorizontalBar() {
        
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = myBlue
        horizontalBarView.layer.cornerRadius = 3.0
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(horizontalBarView)
        
        
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        
        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 4).isActive = true
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
        cv.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
        cv.layer.cornerRadius = 3.0
        cv.layer.borderColor = myBlue.cgColor
        cv.layer.borderWidth = 0.75
        cv.delegate = self
        cv.dataSource = self
        return cv
    } ()
    
    //Collection View Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        
        //cell.imageView.image = UIImage(named: imageArray[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.titleLabel.text = titleArray[indexPath.item]
        cell.titleLabel.tintColor = .green
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: frame.width / 3 , height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        wotdController?.scrollToMenuIndex(menuIndex: indexPath.item)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//Cell within MenuBar
class MenuCell: BaseCell {
    
    //Setup ImageView
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "Syn.")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor(red: 39/255, green: 73/255, blue: 151/255, alpha: 1.0)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    //Setup Label
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font.withSize(10.0)
        label.text = "XXX"
        return label
    } ()
    
    override func setUpViews() {
        super.setUpViews()
        
        backgroundColor = UIColor.white

//        addSubview(imageView)
//        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    
    }
    
    //Set Cell Highlighted and Selected Color
    override var isHighlighted: Bool {
        didSet {
            //imageView.tintColor = isHighlighted ?  UIColor(red: 71/255, green: 117/255, blue: 225/255, alpha: 1.0) : UIColor(red: 39/255, green: 73/255, blue: 151/255, alpha: 1.0)
            titleLabel.tintColor = isHighlighted ? myBlue : .green
        }
    }
    
    override var isSelected: Bool {
        didSet{
           // imageView.tintColor = isSelected ?  UIColor(red: 71/255, green: 117/255, blue: 225/255, alpha: 1.0) : UIColor(red: 39/255, green: 73/255, blue: 151/255, alpha: 1.0)
            titleLabel.tintColor = isSelected ? myBlue : .green
        }
    }
}
