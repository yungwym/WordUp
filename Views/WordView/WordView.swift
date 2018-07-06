//
//  WordView.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-30.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import UIKit

class WordView: UIView {
    
    var wordObject: WordObj?
    
 
    
    //MARK: Load View
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        setupWordView()
    }
    
    func requestAndDisplayWordObject(wordObject: WordObj){
        
        wordLabel.text = wordObject.word
        pronounceLabel.text = "| \(wordObject.pronunciation.all ?? "" ) |"
        speechLabel.text = wordObject.results[0].partOfSpeech
        definitionLabel.text = wordObject.results[0].definition
        
        guard let ex = wordObject.results[0].examples?[0] else {
            exampleLabel.text = ""
            print("No Example")
            return
        }
        exampleLabel.text = ex
        
        
        print(self.wordLabel.text ?? "No Val")
        self.setNeedsDisplay()
    }
    
    func setupWordView() {
        
        addSubview(wordLabel)
        wordLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        wordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25.0).isActive = true
        wordLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25.0).isActive = true
        wordLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 45.0).isActive = true
        
        addSubview(pronounceLabel)
        pronounceLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        pronounceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25.0).isActive = true
        pronounceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25.0).isActive = true
        pronounceLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 4.0).isActive = true
        
        addSubview(speechLabel)
        speechLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        speechLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25.0).isActive = true
        speechLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25.0).isActive = true
        speechLabel.topAnchor.constraint(equalTo: pronounceLabel.bottomAnchor, constant: 8.0).isActive = true
        
        addSubview(definitionLabel)
        definitionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        definitionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25.0).isActive = true
        definitionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25.0).isActive = true
        definitionLabel.topAnchor.constraint(equalTo: speechLabel.bottomAnchor, constant: 20.0).isActive = true
        
        addSubview(exampleLabel)
        exampleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        exampleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25.0).isActive = true
        exampleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25.0).isActive = true
        exampleLabel.topAnchor.constraint(equalTo: definitionLabel.bottomAnchor, constant: 20.0).isActive = true
    }
    
    lazy var wordLabel: UILabel = {
        let wLabel = UILabel()
        wLabel.translatesAutoresizingMaskIntoConstraints = false
        wLabel.textColor = myBlue
        wLabel.font = UIFont.systemFont(ofSize: 30.0, weight: UIFont.Weight.semibold)
        wLabel.textAlignment = .left
        return wLabel
    } ()
    
    lazy var pronounceLabel: UILabel = {
        let pLabel = UILabel()
        pLabel.translatesAutoresizingMaskIntoConstraints = false
        pLabel.textColor = .gray
        pLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
        pLabel.textAlignment = .left
        return pLabel
    } ()
    
    lazy var speechLabel: UILabel = {
        let sLabel = UILabel()
        sLabel.translatesAutoresizingMaskIntoConstraints = false
        sLabel.textColor = .black
        sLabel.font = UIFont.italicSystemFont(ofSize: 16.0)
        sLabel.textAlignment = .left
        return sLabel
    } ()
    
    lazy var definitionLabel: UILabel = {
        let dLabel = UILabel()
        dLabel.translatesAutoresizingMaskIntoConstraints = false
        dLabel.textColor = .black
        dLabel.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.semibold)
        dLabel.textAlignment = .left
        dLabel.numberOfLines = 4
        return dLabel
    } ()
    
    lazy var exampleLabel: UILabel = {
        let exLabel = UILabel()
        exLabel.translatesAutoresizingMaskIntoConstraints = false
        exLabel.textColor = .black
        exLabel.font = UIFont.italicSystemFont(ofSize: 17.0)
        exLabel.textAlignment = .left
        exLabel.numberOfLines = 4
        return exLabel
    } ()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
