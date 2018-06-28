//
//  AntonymCell.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-25.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import UIKit

class AntonymCell: SynonymCell {
    
    var antonymObj: AntonymObj?
    
    override func setUpViews() {
        super.setUpViews()
        
        fetchData()
    }
    
    
    override func fetchData() {
        
        NetworkRequests.requestAntnoyms(forWord: passingWord) { (antonymDetails) in
            
            self.antonymObj = antonymDetails
            
            guard let antArray = self.antonymObj?.antonyms else {
                
                self.wordArray = ["Sorry, we were unable to find any Antonyms for \(passingWord)"]
                return
            }
            self.wordArray = antArray
            print(self.wordArray)
            
            self.sarCollectionView.reloadData()
        }
    }
}
