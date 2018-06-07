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
    

    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkRequests.requestWOTD { (wordItem) in
            
            self.wordItem = wordItem
            print("\(String(describing: self.wordItem?.word))REQUEST WOTD")
            
            NetworkRequests.requestPronounce(forWord: (self.wordItem?.word)!, { (proItem) in
                
                self.proItem = proItem
                
                
            })
            
        }
        
//        NetworkRequests.requestPronounce { (proItem) in
//
//            self.proItem = proItem
//            print("REQUEST PRONOUNCE")
//        }
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                
        let tabBar = segue.destination as? UITabBarController
        let wotdVC = tabBar?.viewControllers?.first as? WOTDVC
        wotdVC?.wotd = self.wordItem
        
    }

    
}
