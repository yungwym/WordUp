//
//  FavouritesCell.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-29.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import UIKit
import CoreData

class FavouritesCell: DictionaryCell {
    
    var favourites = [Favourite]()
    
    var favArray = [String]()
    
    let favCellID = "favCellID"
    
    override func setUpViews() {
        super.setUpViews()
        
        fetchData()
    }
    
    override func fetchData() {
        
        let fetchFav: NSFetchRequest<Favourite> = Favourite.fetchRequest()
        do {
            
            let favs = try PersistenceService.context.fetch(fetchFav)
            self.favourites = favs
            
            for word in favourites {
                
                favArray.append(word.word!)
            }
        } catch {}
        self.dfCollectionView.reloadData()
        wordArray = favArray
    }
}
