//
//  DictionaryCell.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-29.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import UIKit

class DictionaryCell: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let dictionaryVC = DictionaryVC()
    
    var dictWordEntry: WordObj?
    var dictSynEntry: SynonymObj?
    var dictAntEntry: AntonymObj?
    var dictRhymEntry: RhymeObj?
    
    var wordArray = [String]()
    let dfEntryCellID = "dfEntryCell"
    let dispatchGroup = DispatchGroup()
    
    //MARK: Blocks
    lazy var dfCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = myBlue
        cv.dataSource = self
        cv.delegate = self
        return cv
    } ()
    
    override func setUpViews() {
        super.setUpViews()
        
        fetchData()
        
        addSubview(dfCollectionView)
        dfCollectionView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        dfCollectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dfCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        dfCollectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        dfCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        dfCollectionView.layer.borderWidth = 3.0
        dfCollectionView.layer.borderColor = myBlue.cgColor
        
        dfCollectionView.register(EntryCell.self, forCellWithReuseIdentifier: dfEntryCellID)
        
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
    
   
    
    func getSynonymData(word: String) {
        dispatchGroup.enter()
        NetworkRequests.requestSynonyms(forWord: word) { (dictSynEntry) in
            self.dictSynEntry = dictSynEntry
            self.dispatchGroup.leave()
        }
    }
    
    func getAntonymData(word: String) {
        dispatchGroup.enter()
        NetworkRequests.requestAntnoyms(forWord: word) { (dictAntEntry) in
            self.dictAntEntry = dictAntEntry
            self.dispatchGroup.leave()
            
        }
    }
    
    func getRhymeData(word: String) {
        dispatchGroup.enter()
        NetworkRequests.requestRhymes(forWord: word) { (dictRhymEntry) in
            self.dictRhymEntry = dictRhymEntry
            self.dispatchGroup.leave()
        }
    }
    
    
    //MARK: CollectionView Delegate & Datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return wordArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let dfCell = collectionView.dequeueReusableCell(withReuseIdentifier: dfEntryCellID, for: indexPath) as! EntryCell
        
        dfCell.layer.cornerRadius = 3.0
        dfCell.layer.borderWidth = 0.5
        dfCell.layer.borderColor = myBlue.cgColor
        dfCell.titleLabel.text = wordArray[indexPath.item]
        return dfCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let detailView = DetailViewLauncher()
//        detailView.showDetailView(selectedWord: wordArray[indexPath.item])
//        print(wordArray[indexPath.item])
        
       
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height / 8)
    }
}
