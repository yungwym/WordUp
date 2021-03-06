//
//  DictionaryCell.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-29.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import UIKit

class DictionaryCell: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var wordArray = [String]()
    
    let dfEntryCellID = "dfEntryCell"
    
    //MARK: Blocks
    lazy var dfCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor(red: 71/255, green: 117/255, blue: 225/255, alpha: 1.0)
        cv.dataSource = self
        cv.delegate = self
        return cv
    } ()
    
    lazy var warningLabel: UILabel = {
        let wL = UILabel()
        wL.translatesAutoresizingMaskIntoConstraints = false
        wL.text = "Hmmmm, looks like your have no favourites yet"
        wL.textColor = .black
        wL.textAlignment = .center
        wL.numberOfLines = 3
        return wL
    } ()
    
    override func setUpViews() {
        super.setUpViews()
        
        addSubview(dfCollectionView)
        dfCollectionView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        dfCollectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dfCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        dfCollectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        dfCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        dfCollectionView.layer.borderWidth = 0.5
        dfCollectionView.layer.borderColor = UIColor(red: 71/255, green: 117/255, blue: 225/255, alpha: 1.0).cgColor
        
        dfCollectionView.register(DFEntryCell.self, forCellWithReuseIdentifier: dfEntryCellID)
        
        //dfCollectionView.addSubview(warningLabel)
        
//        warningLabel.topAnchor.constraint(equalTo: dfCollectionView.topAnchor, constant: 20.0).isActive = true
//        warningLabel.centerXAnchor.constraint(equalTo: dfCollectionView.centerXAnchor).isActive = true
//        warningLabel.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
        
        
        fetchData()
    }
    
    //MARK: Functions
    func fetchData() {
        
        guard let wordListPath = Bundle.main.path(forResource: "WordListMK2", ofType: "txt"), let list = try? String(contentsOfFile: wordListPath) else  {
            
            return
        }
        wordArray = list.components(separatedBy: "\n")
        wordArray.removeLast()
        dfCollectionView.reloadData()
    }
    
    
    //MARK: CollectionView Delegate & Datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return wordArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let dfCell = collectionView.dequeueReusableCell(withReuseIdentifier: dfEntryCellID, for: indexPath) as! DFEntryCell
        
        dfCell.layer.cornerRadius = 3.0
        dfCell.layer.borderWidth = 0.5
        dfCell.layer.borderColor = UIColor(red: 71/255, green: 117/255, blue: 225/255, alpha: 1.0).cgColor
        dfCell.dfLabel.text = wordArray[indexPath.item]
        return dfCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height / 12)
    }
    
    
    
}
