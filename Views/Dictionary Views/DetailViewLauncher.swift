//
//  DetailViewLauncher.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-07-05.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import UIKit

class DetailViewLauncher: NSObject {
    
    //MARK: Variables and Constants
    var detailWordEntry: WordObj?
    
    let dispatchGroup = DispatchGroup()
    
    //MARK: Blocks
    lazy var detailView: WordView = {
        let dv = WordView()
        dv.translatesAutoresizingMaskIntoConstraints = false
        dv.layer.cornerRadius = 6.0
        return dv
    } ()
    
    func showDetailView(selectedWord: String) {
        
        if let keyWindow = UIApplication.shared.keyWindow {
            
            let blueView = UIView(frame: keyWindow.frame)
            
            blueView.backgroundColor = myBlue
            
            keyWindow.addSubview(blueView)
            setupWordView(totalView: blueView)
            
            UIView.animate(withDuration: 1.5, delay: 0.5, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                blueView.frame = keyWindow.frame
                
            }, completion: nil)
        }
        
        getAndDisplayWordEntry(selectedWord: selectedWord)
        
    }
    
    
    //Setup WordView
    private func setupWordView(totalView: UIView) {
        
        totalView.addSubview(detailView)
        detailView.centerXAnchor.constraint(equalTo: totalView.centerXAnchor).isActive = true
        detailView.topAnchor.constraint(equalTo: totalView.topAnchor, constant: 25.0).isActive = true
        detailView.bottomAnchor.constraint(equalTo: totalView.bottomAnchor, constant: -75.0).isActive = true
        detailView.leadingAnchor.constraint(equalTo: totalView.leadingAnchor, constant: 25.0).isActive = true
        detailView.trailingAnchor.constraint(equalTo: totalView.trailingAnchor, constant: -25.0).isActive = true
        
    }
    
    func getAndDisplayWordEntry(selectedWord: String) {
        
            dispatchGroup.enter()
            NetworkRequests.requestWORDSAPI(forWord: selectedWord) { (detailWord) in
                self.detailWordEntry = detailWord
                self.dispatchGroup.leave()
                
            }
        
        dispatchGroup.notify(queue: .main) {
            
            self.detailView.wordLabel.text = self.detailWordEntry?.word
            self.detailView.pronounceLabel.text = "| \(self.detailWordEntry?.pronunciation.all ?? "" ) |"
            self.detailView.speechLabel.text = self.detailWordEntry?.results[0].partOfSpeech
            self.detailView.definitionLabel.text = self.detailWordEntry?.results[0].definition
            
            guard let ex = self.detailWordEntry?.results[0].examples?[0] else {
                self.detailView.exampleLabel.text = ""
                return
            }
            self.detailView.exampleLabel.text = ex
        }
    }
}
