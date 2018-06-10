//
//  LandingVC.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-01.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import UIKit

class LandingVC: UIViewController {
    
    //MARK: Variables & Constants
    var wordItem: WordEntry.FullWordInfo?
    var proItem: [PronounceEntry]?
    
    
    var wordDetails: WordAPI.WordWithDetails?
    var wordList: WordAPI.WordList?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        WordAPI.requestWORDSLIST(forWord: "tween") { (wordList) in
            
            self.wordList = wordList
        }
        
        
        WordAPI.requestWORDSAPI(forWord: "tween") { (wordDetails) in
            
            self.wordDetails = wordDetails
        }

//        NetworkRequests.requestWOTD { (wordItem) in
//
//            self.wordItem = wordItem
//            print("\(String(describing: self.wordItem?.word))REQUEST WOTD")
//
//            NetworkRequests.requestPronounce(forWord: (self.wordItem?.word)!, { (proItem) in
//
//                self.proItem = proItem
//
//
//            })
        
        }
        
//        NetworkRequests.requestPronounce { (proItem) in
//
//            self.proItem = proItem
//            print("REQUEST PRONOUNCE")
//        }
        
        
        
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                
        let tabBar = segue.destination as? UITabBarController
        let wotdVC = tabBar?.viewControllers?.first as? WOTDVC
        wotdVC?.wotd = self.wordItem
        
    }

    

}
