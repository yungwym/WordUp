//
//  LandingVC.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-01.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import UIKit

var passingWord = String ()

class LandingVC: UIViewController {
    
    //MARK: Variables & Constants
    
    var wordDetails: WordObj?

    
    var synCell: SynonymCell?
    var antCell: AntonymCell?
    var rhyCell: RhymeCell?
    
    
    //    var wotdData: WOTDData?
    var wordList = [String]()
    
    let dispatchGroup = DispatchGroup()
    
    //MARK: Outlets
    @IBOutlet weak var tapToBeginButton: UIButton!
    @IBOutlet weak var circleImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wotdRequest()
    }
    
    //MARK: Functions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let tabBar = segue.destination as? UITabBarController
        let wotdVC = tabBar?.viewControllers?.first as? WOTDVC
        wotdVC?.wordEntry = self.wordDetails
    }
    
    func wotdRequest() {
        
        dispatchGroup.enter()
        
        guard let wordListPath = Bundle.main.path(forResource: "WordListMK2", ofType: "txt"), let list = try? String(contentsOfFile: wordListPath) else  {
            
            return
        }
        
        wordList = list.components(separatedBy: "\n")
        
        let randomWord = wordList[Int(arc4random_uniform(UInt32(wordList.count)))]
        
        passingWord = randomWord
        
        NetworkRequests.requestWORDSAPI(forWord: randomWord) { (wordDetails) in
            
            self.wordDetails = wordDetails
            
            self.dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            
            self.performSegue(withIdentifier: "go", sender: nil)
        }
    }
    
//    func apiTest() {
//
//        guard let wordListPath = Bundle.main.path(forResource: "2000", ofType: "txt"), let list = try? String(contentsOfFile: wordListPath) else  {
//
//            return
//        }
//
//        wordList = list.components(separatedBy: "\n")
//
//        for word in wordList {
//
//        let replaced = word.replacingOccurrences(of: "\\", with: "")
//
//        NetworkRequests.requestWORDSAPI(forWord: replaced) { (wordDetails) in
//
//        }
//
//        }
//    }
    
    
    //MARK: Actions
    
    @IBAction func requestTapped(_ sender: UIButton) {
       
       // apiTest()
        
     //   wotdRequest()
    }
    
}
