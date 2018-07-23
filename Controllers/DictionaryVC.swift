//
//  DictionaryVC.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-29.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import UIKit
import CoreData

class DictionaryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
    @IBOutlet weak var dfTableView: UITableView!
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        dfTableView.backgroundColor = .white
        dfTableView.delegate = self
        dfTableView.dataSource = self
        
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


    
    //MARK: TableView Delegate & Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dfCell = dfTableView.dequeueReusableCell(withIdentifier: "dfCell", for: indexPath) as! DFCell
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableView.frame.height / 8
    }
    
    //MARK: Actions
    
    @IBAction func customSegmentValueChanged(_ sender: Any) {
        
        
        let fetchFav: NSFetchRequest<Favourite> = Favourite.fetchRequest()
        do {
            
            let favs = try PersistenceService.context.fetch(fetchFav)
            self.favouritesArray = favs
        } catch {}
    
        dfTableView.reloadData()
    }
    
    
    @IBAction func unwindToDictionaryVC(_ sender: UIStoryboardSegue) {
        
    
    }
}
