//
//  WOTDVC.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-01.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import UIKit
import CoreData

class WOTDVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
   
    //MARK: Variables & Constants
    var wordEntry: WordObj?
    var synonymsEntry: SynonymObj?
    var antonymsEntry: AntonymObj?
    var rhymesEntry: RhymeObj?
    
    var favouriteSet = Set<String>()
    
    
    //MARK: Outlets
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var pronounceLabel: UILabel!
    @IBOutlet weak var speechLabel: UILabel!
    @IBOutlet weak var definitionLabel: UILabel!
    @IBOutlet weak var exampleLabel: UILabel!
    
    @IBOutlet weak var sarCollectionView: UICollectionView!
    @IBOutlet weak var secondaryView: UIView!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var customSegmentedController: CustomSegmentedController!
    
    @IBOutlet weak var favouriteBarView: UIView!
    @IBOutlet weak var favouriteBarLabel: UILabel!
    
    @IBOutlet weak var datelabel: UILabel!
    
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        displayWordEntry()
    //    fetchFavourites()
        
        sarCollectionView.delegate = self
        sarCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        fetchFavourites()
    }
    
    //MARK: Functions
    func fetchFavourites() {
        let fetchFav: NSFetchRequest<Favourite> = Favourite.fetchRequest()
        do {
            let favs = try PersistenceService.context.fetch(fetchFav)
            
            for f in favs {
                
                favouriteSet.insert(f.word!)
            }
        } catch {}
        print(favouriteSet)
        
        if favouriteSet.contains((wordEntry?.word)!) {
            //Show unfavourited Button & View
            print("Favourited")
            favouriteButton.setImage(#imageLiteral(resourceName: "FavDark"), for: .normal)
        } else {
            //Show favourited button & View
            print("Not Favourited")
            favouriteButton.setImage(#imageLiteral(resourceName: "FavLight"), for: .normal)
        }
    }

    func setUpViews() {
        
        sarCollectionView.backgroundColor = .white
        sarCollectionView.layer.borderColor = myBlue.cgColor
        sarCollectionView.layer.borderWidth = 3
        sarCollectionView.layer.cornerRadius = 6
        
        secondaryView.layer.cornerRadius = 6
        
        favouriteBarView.alpha = 0
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM, dd, YYYY"
        let dateString = formatter.string(from: Date())
        datelabel.text = dateString
    }
   
    func displayWordEntry() {

        wordLabel.text = wordEntry?.word
        pronounceLabel.text = "| \(wordEntry?.pronunciation.all ?? "" ) |"
        speechLabel.text = wordEntry?.results[0].partOfSpeech
        definitionLabel.text = wordEntry?.results[0].definition

        guard let ex = wordEntry?.results[0].examples?[0] else {
            exampleLabel.text = "Example Unavailable"
          //  print("No Example")
            return
        }
        exampleLabel.text = ex
    }

    
    //MARK: CollectionView Delegate & Datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch customSegmentedController.selectedSegmentIndex {
        case 0:
            guard let synArray = wordEntry?.results[0].synonyms else {
                return 0
            }
            return synArray.count
            
        case 1:
            guard let antArray = antonymsEntry?.antonyms else {
                return 0
            }
            return antArray.count
            
        case 2:
            guard let rhyArray = rhymesEntry?.rhymes.all else {
                return 0
            }
            return rhyArray.count
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sarCell = sarCollectionView.dequeueReusableCell(withReuseIdentifier: "sarCell", for: indexPath) as! SARCell
        
        switch customSegmentedController.selectedSegmentIndex {
        case 0:
            sarCell.wordLabel.text = wordEntry?.results[0].synonyms![indexPath.item]
        case 1:
            sarCell.wordLabel.text = antonymsEntry?.antonyms[indexPath.item]
        case 2:
            sarCell.wordLabel.text = rhymesEntry?.rhymes.all![indexPath.item]
        default:
            break
        }
        return sarCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height / 4)
    }
    
    
    //MARK: Actions
    @IBAction func customSegmentValueChanged(_ sender: Any) {
        sarCollectionView.reloadData()
    }
  
    @IBAction func favTapped(_ sender: UIButton) {
        
        let favDark = UIImage(named:"FavDark")
        let favLight = UIImage(named: "FavLight")
        
        if sender.currentImage ==  favLight {
            //Add to Favourites
            sender.setImage(favDark, for: .normal)
            displayFavBar(status: "added to favourites")
            PersistenceService.createFavourite(wordObj: (wordEntry)!)
        } else {
            //Remove from favourites
            sender.setImage(favLight, for: .normal)
            displayFavBar(status: "removed From favourites")
            let word = PersistenceService.fetchWithPredicate(word: (wordEntry?.word)!)
            PersistenceService.delete(favourite: word!)
        }
    }
    
    func displayFavBar(status: String) {
        
        favouriteBarLabel.text = status
        
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.datelabel.isHidden = true
            self.favouriteBarView.alpha = 100
            self.view.layoutIfNeeded()
        }) { (true) in
            UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                  self.datelabel.isHidden = false
                self.favouriteBarView.alpha = 0
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
}
