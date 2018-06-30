//
//  RhymeCell.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-25.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import UIKit

class RhymeCell: SynonymCell {
    
    var rhymeObj: RhymeObj?
    
    override func setUpViews() {
        super.setUpViews()
        
        fetchData()
    }
    
    override func fetchData() {
        
        NetworkRequests.requestRhymes(forWord: passingWord) { (rhymesDetails) in
            
            self.rhymeObj = rhymesDetails
            
            guard let rhymeArray = self.rhymeObj?.rhymes.all else {
                self.wordArray = ["Sorry, we were unable to find any Rhymes for \(passingWord)"]
                return
            }
            self.wordArray = rhymeArray
            
            self.sarCollectionView.reloadData()
        }
    }
}
