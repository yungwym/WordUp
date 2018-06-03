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
    

    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkRequests.requestWOTD { (wordItem) in
            
            self.wordItem = wordItem
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let wotdVC = segue.destination as? WOTDVC else { return }
        wotdVC.wotd = self.wordItem
        
    }

    
}
