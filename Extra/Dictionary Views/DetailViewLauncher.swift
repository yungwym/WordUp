//
//  DetailViewLauncher.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-07-05.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import UIKit

class BackButtonView: UIView {
    
    
    
    
}

class DetailViewLauncher: NSObject {
    
    //MARK: Variables and Constants
    var detailWordEntry: WordObj?
    
    let dispatchGroup = DispatchGroup()
    
    var blueView = UIView()
    
    //MARK: Blocks
    lazy var detailView: WordView = {
        let dv = WordView()
        dv.translatesAutoresizingMaskIntoConstraints = false
        dv.layer.cornerRadius = 6.0
        return dv
    } ()
    
    lazy var backButtonView: UIView = {
        let bbV = UIView()
        bbV.translatesAutoresizingMaskIntoConstraints = false
        bbV.layer.cornerRadius = 6.0
        bbV.backgroundColor = .white
        return bbV
    } ()
    
    lazy var backButton: UIButton = {
        let bb = UIButton()
        bb.translatesAutoresizingMaskIntoConstraints = false
        bb.setTitle("Back", for: .normal)
        bb.setTitleColor( .white, for: .normal)
        
        return bb
    } ()
    
    func showDetailView(selectedWord: String) {
        
        if let keyWindow = UIApplication.shared.keyWindow {
            
            blueView = UIView(frame: keyWindow.frame)
            
            blueView.backgroundColor = myBlue
            
            keyWindow.addSubview(blueView)
            setupWordView(totalView: blueView)
            backButton.addTarget(self.blueView, action: #selector(backTapped(_:)), for: .touchUpInside)
            
            UIView.animate(withDuration: 1.5, delay: 0.5, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blueView.frame = keyWindow.frame
                
            }, completion: nil)
        }
        getAndDisplayWordEntry(selectedWord: selectedWord)
    }
    
    @objc func backTapped(_ sender: UIButton) {
        print("BACK TAPPED")
        
       // blueView.frame = CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0)
    }
    
    //Setup WordView
    private func setupWordView(totalView: UIView) {
        
        totalView.addSubview(detailView)
        detailView.centerXAnchor.constraint(equalTo: totalView.centerXAnchor).isActive = true
        detailView.topAnchor.constraint(equalTo: totalView.topAnchor, constant: 75.0).isActive = true
        detailView.bottomAnchor.constraint(equalTo: totalView.bottomAnchor, constant: -25.0).isActive = true
        detailView.leadingAnchor.constraint(equalTo: totalView.leadingAnchor, constant: 25.0).isActive = true
        detailView.trailingAnchor.constraint(equalTo: totalView.trailingAnchor, constant: -25.0).isActive = true
        
        totalView.addSubview(backButton)
        backButton.leadingAnchor.constraint(equalTo: detailView.leadingAnchor).isActive = true
        backButton.bottomAnchor.constraint(equalTo: detailView.topAnchor, constant: -8.0).isActive = true
        backButton.topAnchor.constraint(equalTo: totalView.topAnchor, constant: 20.0).isActive = true
        backButton.widthAnchor.constraint(equalTo: detailView.widthAnchor, multiplier: 1/3).isActive = true
        
 
        
//        backButtonView.addSubview(backButton)
//        backButton.centerXAnchor.constraint(equalTo: backButtonView.centerXAnchor).isActive = true
//        backButton.centerYAnchor.constraint(equalTo: backButtonView.centerYAnchor).isActive = true
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
