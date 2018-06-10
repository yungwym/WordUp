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

    var wordDetails: WordEntry?
    var wordList = [String]()
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

    }
        
        
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
////        let tabBar = segue.destination as? UITabBarController
////        let wotdVC = tabBar?.viewControllers?.first as? WOTDVC
////
//        
//    }
    
    
    func wotdRequest() {
        
        guard let wordListPath = Bundle.main.path(forResource: "WordListMK2", ofType: "txt"), let list = try? String(contentsOfFile: wordListPath) else  {
            
            return
        }
        
        wordList = list.components(separatedBy: "\n")
        
        let randomWord = wordList[Int(arc4random_uniform(UInt32(wordList.count)))]
        
        NetworkRequests.requestWORDSAPI(forWord: randomWord) { (wordDetails) in
            
            self.wordDetails = wordDetails
        }
    }

    
    @IBAction func requestTapped(_ sender: UIButton) {
        
        
        wotdRequest()
    }
    
}
