//
//  DictionaryTVC.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-16.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import UIKit
import CoreData

class DictionaryTVC: UITableViewController {
    
    //MARK: Variables
    var wordList: [String]?
    var dictWordEntry: WordObj?
    var dictAntEntry: AntonymObj?
    var dictRhymEntry: RhymeObj?
    
    let dispatchGroup = DispatchGroup()
    
    var favorites = [Favourite]()
    
    //Outlets
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        wordListConfig()
        
        self.tableView.rowHeight = 80
   
    }
    
    //MARK: Functions
    
    func wordListConfig () {
        guard let wordListPath = Bundle.main.path(forResource: "WordListMK2", ofType: "txt"), let list = try? String(contentsOfFile: wordListPath) else  {
            
            return
        }
        wordList = list.components(separatedBy: "\n")
    }
    
    func getWordData(word: String) {
        dispatchGroup.enter()
        NetworkRequests.requestWORDSAPI(forWord: word) { (dictWordEntry) in
            self.dictWordEntry = dictWordEntry
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
    

    // MARK: TableView Delegate & Datasoure

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch segmentControl.selectedSegmentIndex {
        case 0:
            return (wordList?.count)!

        case 1:
            return favorites.count
            
        default:
            break
        }
        return 0
    }

    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let dictCell = tableView.dequeueReusableCell(withIdentifier: "dictionaryCell", for: indexPath) as! DictionaryCell
//
//        switch segmentControl.selectedSegmentIndex {
//        case 0:
//              dictCell.wordLabel.text = wordList?[indexPath.row].capitalized
//
//        case 1:
//            dictCell.wordLabel.text = favorites[indexPath.row].word?.capitalized
//
//        default:
//            break
//        }
//        return dictCell
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let passingWord: String
        
        switch segmentControl.selectedSegmentIndex {
        case 0:
            passingWord = wordList![indexPath.row]
        case 1:
            passingWord = favorites[indexPath.row].word!
        default:
            return
        }
        getWordData(word: passingWord)
        getAntonymData(word: passingWord)
        getRhymeData(word: passingWord)
        
        dispatchGroup.notify(queue: .main) {
            if let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "Detail") as? DictionaryDetailVC  {
                
                switch self.segmentControl.selectedSegmentIndex {
                case 0:
                    detailVC.wordEntry = self.dictWordEntry

                case 1:
                    detailVC.wordEntry = self.dictWordEntry
                    detailVC.show = false
                    
                default:
                    break
                    
                }
                print(self.dictWordEntry?.word ?? "NO VALUE 4 DICT")
                print(detailVC.wordEntry?.word ?? "NO VALUE 4 DETAIL")
                
                self.navigationController?.pushViewController(detailVC, animated: true)
                
            }
        }
    }
    
    //MARK: Actions
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        let fetchFav: NSFetchRequest<Favourite> = Favourite.fetchRequest()
        do {
            
            let favs = try PersistenceService.context.fetch(fetchFav)
            self.favorites = favs
        } catch {}
        
        self.tableView.reloadData()
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
