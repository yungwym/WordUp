//
//  WOTDVC.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-01.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import UIKit

class WOTDVC: UIViewController {
    
    //MARK: Variables & Constants
    
    var wotd: WordEntry.FullWordInfo?
    
    
    //MARK: Outlets
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var pronounceLabel: UILabel!
    @IBOutlet weak var defLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var exLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(wotd?.word ?? "Not Yet")
        
        wordLabel.text = wotd?.word
        noteLabel.text = wotd?.note
        defLabel.text = wotd?.definitions[0].text
        exLabel.text = wotd?.examples[0].text
        
    
        // Do any additional setup after loading the view.
    }
}
