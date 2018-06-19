//
//  WOTDVC.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-01.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import UIKit

class WOTDVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: Variables & Constants
    var wordEntry: WordEntry?
    var antonyms: AntonymInfo?
    var rhymes: RhymesInfo?
    
    
    //MARK: Outlets
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var pronounceLabel: UILabel!
    @IBOutlet weak var defLabel: UILabel!
    @IBOutlet weak var exLabel: UILabel!
    @IBOutlet weak var speechLabel: UILabel!
    
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        displayWordEntry()
        
    }
    
    //MARK: Functions
    
    func displayWordEntry() {
        
        wordLabel.text = wordEntry?.word?.capitalized
        pronounceLabel.text = wordEntry?.pronunciation.all
        speechLabel.text = wordEntry?.results[0].partOfSpeech
        defLabel.text = wordEntry?.results[0].definition
        
        guard let ex = wordEntry?.results[0].examples?[0] else {
            print("No Example")
            return
        }
        exLabel.text = ex
    }
    
    
    //MARK: CollectionView Delegate & Datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch segmentController.selectedSegmentIndex {
        case 0:
            return (wordEntry?.results[0].synonyms?.count)!
        
        case 1:
            return (antonyms?.antonyms.count)!
            
        case 2:
            return (rhymes?.rhymes.all!.count)!
        default:
            break
        }
        
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let wotdCell = collectionView.dequeueReusableCell(withReuseIdentifier: "wotdCell", for: indexPath) as! WOTDCell
        
        switch segmentController.selectedSegmentIndex {
        case 0:
            wotdCell.wordLabel.text = wordEntry?.results[0].synonyms![indexPath.row]
        
        case 1:
            wotdCell.wordLabel.text = antonyms?.antonyms[indexPath.row]
            
        case 2:
            wotdCell.wordLabel.text = rhymes?.rhymes.all![indexPath.row]
            
        default:
            break
        }
        
        return wotdCell
    }
    
    //MARK: Actions
    
    @IBAction func segmentChanged(_ sender: Any) {
        
        collectionView.reloadData()
        
    }
    
    
}
