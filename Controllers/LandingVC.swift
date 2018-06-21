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
    var antonymsDetails: AntonymInfo?
    var rhymesDetails: RhymesInfo?
    
//    var wotdData: WOTDData?
    var wordList = [String]()
    
      let dispatchGroup = DispatchGroup()
    
    //MARK: Outlets
    @IBOutlet weak var tapToBeginButton: UIButton!
    @IBOutlet weak var circleImageView: UIImageView!
    
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wotdRequest()
        
        blink()
        
    }
        
    //MARK: Functions
    
    func blink() {
        
        UIView.animate(withDuration: 1.3, delay: 0.5, options: [.curveEaseIn, .repeat, .autoreverse], animations: {
            
            self.circleImageView.alpha = 0.0
            
        }, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let tabBar = segue.destination as? UITabBarController
        let wotdVC = tabBar?.viewControllers?.first as? WOTDVC
        wotdVC?.wordEntry = self.wordDetails
        wotdVC?.antonyms = self.antonymsDetails
        wotdVC?.rhymes = self.rhymesDetails
    }
    
    
    func wotdRequest() {
        
        dispatchGroup.enter()
        
        guard let wordListPath = Bundle.main.path(forResource: "WordListMK2", ofType: "txt"), let list = try? String(contentsOfFile: wordListPath) else  {
            
            return
        }
        
        wordList = list.components(separatedBy: "\n")
        
        let randomWord = wordList[Int(arc4random_uniform(UInt32(wordList.count)))]
        
        NetworkRequests.requestWORDSAPI(forWord: randomWord) { (wordDetails) in
            
            self.wordDetails = wordDetails
            
        }
        
        NetworkRequests.requestRhymes(forWord: randomWord) { (rhymesDetails) in
            
            self.rhymesDetails = rhymesDetails
            
        }
        
        NetworkRequests.requestAntnoyms(forWord: randomWord) { (antonymDetails) in
            
            self.antonymsDetails = antonymDetails
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
