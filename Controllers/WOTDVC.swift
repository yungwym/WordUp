//
//  WOTDVC.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-01.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import UIKit

class WOTDVC: UIViewController {
    
    //MARK: Variables & Constants
    var wordEntry: WordEntry?
    
    
    //MARK: Outlets
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var pronounceLabel: UILabel!
    @IBOutlet weak var defLabel: UILabel!
    @IBOutlet weak var exLabel: UILabel!
    @IBOutlet weak var speechLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayWordEntry()
        
    }
    
    //MARK: Functions
    
    func displayWordEntry() {
        
        wordLabel.text = wordEntry?.word.capitalized
        pronounceLabel.text = ("| \(wordEntry?.pronunciation.all ?? "") |")
        defLabel.text = wordEntry?.results[0].definition
        speechLabel.text = wordEntry?.results[0].partOfSpeech
        exLabel.text = (" \(wordEntry?.results[0].examples?[0] ?? "") ")
        
    }
    
    
    //MARK: CollectionView Delegate & Datasource
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//
//        return 3
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//    }
    
    
    
    
}
