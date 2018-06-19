//
//  DictionaryTVC.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-16.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import UIKit

class DictionaryTVC: UITableViewController {
    
    //MARK: Variables
    var wordList: [String]?
    var dictWordEntry: WordEntry?
    var dictAntEntry: AntonymInfo?
    var dictRhymEntry: RhymesInfo?
    
     let dispatchGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wordListConfig()
        
        self.tableView.rowHeight = 80
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (wordList?.count)!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dictCell = tableView.dequeueReusableCell(withIdentifier: "dictionaryCell", for: indexPath) as! DictionaryCell
        dictCell.wordLabel.text = wordList?[indexPath.row].capitalized
        return dictCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let passingWord = wordList![indexPath.row]
        
        getWordData(word: passingWord)
        getAntonymData(word: passingWord)
        getRhymeData(word: passingWord)
        
        dispatchGroup.notify(queue: .main) {
            if let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "Detail") as? DictionaryDetailVC  {
                
                detailVC.wordEntry = self.dictWordEntry
                
                print(self.dictWordEntry?.word ?? "NO VALUE 4 DICT")
                print(detailVC.wordEntry?.word ?? "NO VALUE 4 DETAIL")
                
                
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
        }
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
