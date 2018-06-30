//
//  SynonymCell.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-26.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import UIKit

class SynonymCell: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var wordArray = [String]()
    
    //Change to SynonymInfo
    var synonymObj: SynonymObj?
    
    let sarEntryID = "sarEntryID"
    
    lazy var sarCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let sarCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        sarCV.translatesAutoresizingMaskIntoConstraints = false
        sarCV.backgroundColor = myBlue
        sarCV.delegate = self
        sarCV.dataSource = self
        return sarCV
    }()
    
    
    override func setUpViews() {
        super.setUpViews()
        
        fetchData()
        
        addSubview(sarCollectionView)
        sarCollectionView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        sarCollectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        sarCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        sarCollectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sarCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        sarCollectionView.register(SAREntryCell.self, forCellWithReuseIdentifier: sarEntryID)
    }
    //Functions
    func fetchData() {
        
        NetworkRequests.requestSynonyms(forWord: passingWord) { (synonymDetails) in
            
            self.synonymObj = synonymDetails
            
            guard let synArray = self.synonymObj?.synonyms else {
                
                self.wordArray = ["Sorry, we were unable to find any Synonyms for \(passingWord)"]
                return
            }
            
    
            self.wordArray = synArray
            print(self.wordArray)
            self.sarCollectionView.reloadData()
        }
    }
    
    
    //MARK: CollectionView Delegate & Datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return wordArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: sarEntryID, for: indexPath) as! SAREntryCell
        cell.layer.cornerRadius = 3.0
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor(red: 71/255, green: 117/255, blue: 225/255, alpha: 1.0).cgColor
        cell.sarLabel.text = wordArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
     //   let og width = 137.5
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height / 4)
    }
    
    
}
