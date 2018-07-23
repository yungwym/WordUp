//
//  LandingVC.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-01.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import UIKit
import CoreData

let myBlue = UIColor(red: 71/255, green: 117/255, blue: 225/255, alpha: 1.0)
var passingWord = String ()

class LandingVC: UIViewController {
    
    //MARK: Variables & Constants
    var landingWordCollection: WordCollection?
    
    
    var wordDetails: WordObj?
    var antonymDetails: AntonymObj?
    var rhymeDetails: RhymeObj?
    
     var testWordObj: WordObj?
    
    //    var wotdData: WOTDData?
    var wordList = [String]()
    
    let dispatchGroup = DispatchGroup()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        wotdRequest()
    }
    
    //MARK: Functions    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let tabBar = segue.destination as? UITabBarController
        let wotdVC = tabBar?.viewControllers?.first as? WOTDVC
        wotdVC?.wordEntry = self.wordDetails
        wotdVC?.antonymsEntry = self.antonymDetails
        wotdVC?.rhymesEntry = self.rhymeDetails
    }
    
    func wotdRequest() {
        
        guard let wordListPath = Bundle.main.path(forResource: "ReOne", ofType: "txt"), let list = try? String(contentsOfFile: wordListPath) else  {
            return
        }
        
        wordList = list.components(separatedBy: "\n")
        let randomWord = wordList[Int(arc4random_uniform(UInt32(wordList.count)))]
        passingWord = randomWord
     
        getWordData(word: randomWord)
        getAntonymData(word: randomWord)
        getRhymeData(word: randomWord)

        dispatchGroup.notify(queue: .main) {
            self.performSegue(withIdentifier: "go", sender: nil)
        }
    }
    
    func getWordData(word: String) {
        dispatchGroup.enter()
        NetworkRequests.requestWORDSAPI(forWord: word) { (wDetails) in
            self.wordDetails = wDetails
            self.dispatchGroup.leave()
        }
    }
    
    func getAntonymData(word: String) {
        dispatchGroup.enter()
        NetworkRequests.requestAntnoyms(forWord: word) { (aDetails) in
            self.antonymDetails = aDetails
            self.dispatchGroup.leave()
        }
    }
    
    func getRhymeData(word: String) {
        dispatchGroup.enter()
        NetworkRequests.requestRhymes(forWord: word) { (rDetails) in
            self.rhymeDetails = rDetails
            self.dispatchGroup.leave()
        }
    }
        
    
    func apiTest() {
        
        var incompleteWordsArray = [WordObj]()
        var completeWordsArray = [String]()
        
        guard let wordListPath = Bundle.main.path(forResource: "2700", ofType: "txt"), let list = try? String(contentsOfFile: wordListPath) else  {
            
            return
        }
        
        wordList = list.components(separatedBy: "\n")
        
        for word in wordList {
            
            let replaced = word.replacingOccurrences(of: "\\", with: "")
            
            NetworkRequests.requestWORDSAPI(forWord: replaced) { (wordDetails) in
                
                self.testWordObj = wordDetails
                
                guard let word = self.testWordObj?.word, let pronun = self.testWordObj?.pronunciation.all, let speech = self.testWordObj?.results[0].partOfSpeech, let def = self.testWordObj?.results[0].definition, let ex = self.testWordObj?.results[0].examples?[0] else {
                    
                    incompleteWordsArray.append(self.testWordObj!)
                    return
                }
                completeWordsArray.append(self.testWordObj!.word!)
                
                
                print("INCOMPLETE: \(incompleteWordsArray.count)")
                print("COMPLETE: \(completeWordsArray.count)")
                print(completeWordsArray)
                
            }
        }
        
        
    }
    
    
    //MARK: Actions
    
    @IBAction func requestTapped(_ sender: UIButton) {
       
        apiTest()
        
     //   wotdRequest()
    }
    
}
