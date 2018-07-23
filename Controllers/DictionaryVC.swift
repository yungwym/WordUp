//
//  DictionaryVC.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-29.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import UIKit
import CoreData

class DictionaryVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: Variables & Constants
    var detailWordObject: WordObj?
    var detailAntonymObject: AntonymObj?
    var detailRhymeObject: RhymeObj?
    
    var favouritesArray = [Favourite]()
    var wordList = [String]()
    
    let dispatchGroup = DispatchGroup()
    
    var sarArray = [String]()
    
    
    
    //MARK: Outlets
    @IBOutlet weak var secondaryBackgroundView: UIView!
    @IBOutlet weak var customSegmentedController: CustomSegmentedController!
    @IBOutlet weak var dfCollectionView: UICollectionView!
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
        dfCollectionView.backgroundColor = .white
        dfCollectionView.delegate = self
        dfCollectionView.dataSource = self
        
        wordListConfig()
        setUpViews()
    }
    
    //MARK: Functions
    func setUpViews() {
        secondaryBackgroundView.layer.cornerRadius = 6.0
        
    }
    
    func wordListConfig () {
        guard let wordListPath = Bundle.main.path(forResource: "ReOne", ofType: "txt"), let list = try? String(contentsOfFile: wordListPath) else  {
            return
        }
        wordList = list.components(separatedBy: "\n")
        wordList.removeLast()
    }
    
    
    func getWordData(word: String) {
        dispatchGroup.enter()
        NetworkRequests.requestWORDSAPI(forWord: word) { (wordEntry) in
            self.detailWordObject = wordEntry
            self.dispatchGroup.leave()
        }
    }
    
    func getAntonymData(word: String) {
        dispatchGroup.enter()
        NetworkRequests.requestAntnoyms(forWord: word) { (antEntry) in
            self.detailAntonymObject = antEntry
            self.dispatchGroup.leave()
        }
    }
    
    func getRhymeData(word: String) {
        dispatchGroup.enter()
        NetworkRequests.requestRhymes(forWord: word) { (rhymEntry) in
            self.detailRhymeObject = rhymEntry
            self.dispatchGroup.leave()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let detailVC = segue.destination as? DictionaryDetailVC
        detailVC?.wordEntry = self.detailWordObject
        detailVC?.antonymsEntry = self.detailAntonymObject
        detailVC?.rhymesEntry = self.detailRhymeObject
        
        switch customSegmentedController.selectedSegmentIndex {
        case 1:
            detailVC?.favButtonSelect = "FavDark"
        default:
            detailVC?.favButtonSelect = "FavLight"
        }
    }

    //MARK: CollectionView Delegate & Datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch customSegmentedController.selectedSegmentIndex {
        case 0:
            return (wordList.count)
            
        case 1:
            return (favouritesArray.count)
            
        default:
            break
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let dfCell = dfCollectionView.dequeueReusableCell(withReuseIdentifier: "dfEntry", for: indexPath) as! DFCell
        
        switch customSegmentedController.selectedSegmentIndex {
        case 0:
            dfCell.wordLabel.text = wordList[indexPath.item]
        case 1:
            dfCell.wordLabel.text = favouritesArray[indexPath.item].word
    
        default:
            break
        }
        return dfCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedWord: String
    
        switch customSegmentedController.selectedSegmentIndex {
        case 0:
            selectedWord = wordList[indexPath.item]
            getWordData(word: selectedWord)
           
            
        case 1:
            selectedWord = favouritesArray[indexPath.item].word!
            getWordData(word: selectedWord)
            
        default:
            break
        }
        
        dispatchGroup.notify(queue: .main) {
                self.performSegue(withIdentifier: "detailPop", sender: nil)
            print(self.sarArray)
        }
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
    
    //MARK: Actions
    
    @IBAction func customSegmentValueChanged(_ sender: Any) {
        
        
        let fetchFav: NSFetchRequest<Favourite> = Favourite.fetchRequest()
        do {
            
            let favs = try PersistenceService.context.fetch(fetchFav)
            self.favouritesArray = favs
        } catch {}
    
        dfCollectionView.reloadData()
    }
    
    
    @IBAction func unwindToDictionaryVC(_ sender: UIStoryboardSegue) {
        
    
    }
}
