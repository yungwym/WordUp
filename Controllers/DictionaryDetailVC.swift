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
    var wordEntry: WordObj?
    var synonyms: SynonymObj?
    var antonyms: AntonymObj?
    var rhymes: RhymeObj?
    
    var show = true
    
    //MARK: Outlets
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var pronunceLabel: UILabel!
    @IBOutlet weak var speechLabel: UILabel!
    @IBOutlet weak var definitionLabel: UILabel!
    @IBOutlet weak var exLabel: UILabel!
    
    @IBOutlet weak var favButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayWordEntry()
        displayButton()
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
    
    func displayButton() {
        if (show == true) {
            favButton.isHidden = false
        } else {
            favButton.isHidden = true
        }
    }
    
    //MARK: Actions
    
    @IBAction func favTapped(_ sender: UIButton) {
        
        let fav = Favourite(context: PersistenceService.context)
        
        fav.word = wordEntry?.word
        fav.speech = wordEntry?.results[0].partOfSpeech
        fav.pronunce = wordEntry?.pronunciation.all
        fav.definition = wordEntry?.results[0].definition
        //   fav.example = wordEntry?.results[0].examples![0]
        
        PersistenceService.saveContext()
    }
}
