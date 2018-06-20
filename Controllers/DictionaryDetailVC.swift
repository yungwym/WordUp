//
//  DictionaryDetailVC.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-17.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import UIKit

class DictionaryDetailVC: UIViewController {
    
    //MARK: Variables
    var wordEntry: WordEntry?
    var antonyms: AntonymInfo?
    var rhymes: RhymesInfo?
    
    //MARK: Outlets
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var pronunceLabel: UILabel!
    @IBOutlet weak var speechLabel: UILabel!
    @IBOutlet weak var definitionLabel: UILabel!
    @IBOutlet weak var exLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayWordEntry()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Functions
    
    func displayWordEntry() {
        
        wordLabel.text = wordEntry?.word?.capitalized
        pronunceLabel.text = wordEntry?.pronunciation.all
        speechLabel.text = wordEntry?.results[0].partOfSpeech
        definitionLabel.text = wordEntry?.results[0].definition
        
        guard let ex = wordEntry?.results[0].examples?[0] else {
            print("No Example")
            return
        }
        exLabel.text = ex
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
