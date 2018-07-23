//
//  WordView.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-30.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import UIKit
import CoreData

class WordView: UIView  {
    
    //UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
    
    //MARK: Variables and Constants
    var wordObject: WordObj?
    let synCellID = "synCellID"
    let antCellID = "antCellID"
    let rhyCellID = "rhyCellID"
    
    //MARK: Load View
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        backgroundColor = .white
//        setupWordView()
//    }
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//
//        fatalError("init(coder:) has not been implemented")
//
//    }
    
    
//     var viewBackgroundColor: UIColor = .white {
//        didSet{self.backgroundColor = viewBackgroundColor}
//    }
    
    var primaryTextColor: UIColor = .black {
        didSet{updateView()}
    }
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.height / 6
    }
    
    func updateView() {
        
        
        wordLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        wordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25.0).isActive = true
        wordLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25.0).isActive = true
        wordLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 45.0).isActive = true
        addSubview(wordLabel)
        
        
        pronounceLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        pronounceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25.0).isActive = true
        pronounceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25.0).isActive = true
        pronounceLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 4.0).isActive = true
        addSubview(pronounceLabel)
        
        speechLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        speechLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25.0).isActive = true
        speechLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25.0).isActive = true
        speechLabel.topAnchor.constraint(equalTo: pronounceLabel.bottomAnchor, constant: 8.0).isActive = true
        addSubview(speechLabel)

        definitionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        definitionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25.0).isActive = true
        definitionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25.0).isActive = true
        definitionLabel.topAnchor.constraint(equalTo: speechLabel.bottomAnchor, constant: 20.0).isActive = true
        addSubview(definitionLabel)

        exampleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        exampleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25.0).isActive = true
        exampleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25.0).isActive = true
        exampleLabel.topAnchor.constraint(equalTo: definitionLabel.bottomAnchor, constant: 20.0).isActive = true
        addSubview(exampleLabel)

        favouriteButton.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        favouriteButton.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        favouriteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 40.0).isActive = true
        favouriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25.0).isActive = true
        addSubview(favouriteButton)

        
//        setUpMenuBar()
//        setupCollectionView()
    }
    
//    private func setUpMenuBar() {
//
//        self.addSubview(menuBar)
//        menuBar.clipsToBounds = true
//        menuBar.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        menuBar.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//        menuBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
//        menuBar.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
//    }
//
//    private func setupCollectionView() {
//
//        self.addSubview(infoCollectionView)
//
//        infoCollectionView.isPagingEnabled = true
//        infoCollectionView.showsHorizontalScrollIndicator = false
//        infoCollectionView.backgroundColor = myBlue
//        //collectionView.centerYAnchor.constraint(equalTo: menuBar.centerYAnchor, constant: 40).isActive = true
//        infoCollectionView.topAnchor.constraint(equalTo: menuBar.bottomAnchor, constant: 4).isActive = true
//        infoCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -25).isActive = true
//        infoCollectionView.centerXAnchor.constraint(equalTo: menuBar.centerXAnchor).isActive = true
//        infoCollectionView.leadingAnchor.constraint(equalTo: menuBar.leadingAnchor).isActive = true
//        //collectionView.heightAnchor.constraint(equalToConstant: 150.0).isActive = true
//        infoCollectionView.layer.cornerRadius = 3.0
//        infoCollectionView.layer.borderColor = UIColor(red: 71/255, green: 117/255, blue: 225/255, alpha: 1.0).cgColor
//        infoCollectionView.layer.borderWidth = 3.0
//
//        infoCollectionView.register(SynonymCell.self, forCellWithReuseIdentifier: synCellID)
//        infoCollectionView.register(AntonymCell.self, forCellWithReuseIdentifier: antCellID)
//        infoCollectionView.register(RhymeCell.self, forCellWithReuseIdentifier: rhyCellID)
//    }
    
    @objc func favTapped(_ sender: UIButton) {
        
        print("FAVOURITED")
        
//        let fav = Favourite(context: PersistenceService.context)
//
//        fav.word = wordEntry?.word
//        fav.speech = wordEntry?.results[0].partOfSpeech
//        fav.pronunce = wordEntry?.pronunciation.all
//        fav.definition = wordEntry?.results[0].definition
//        //   fav.example = wordEntry?.results[0].examples![0]
//
//        PersistenceService.saveContext()
//
    }
    
    
    //MARK: Blocks
    lazy var wordLabel: UILabel = {
        let wLabel = UILabel()
        wLabel.translatesAutoresizingMaskIntoConstraints = false
        wLabel.textColor = myBlue
        wLabel.text = "Word"
        wLabel.font = UIFont.systemFont(ofSize: 30.0, weight: UIFont.Weight.semibold)
        wLabel.textAlignment = .left
        return wLabel
    } ()
    
    lazy var pronounceLabel: UILabel = {
        let pLabel = UILabel()
        pLabel.translatesAutoresizingMaskIntoConstraints = false
        pLabel.textColor = .gray
        pLabel.text = "Pronounce"
        pLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
        pLabel.textAlignment = .left
        return pLabel
    } ()
    
    lazy var speechLabel: UILabel = {
        let sLabel = UILabel()
        sLabel.translatesAutoresizingMaskIntoConstraints = false
        sLabel.textColor = .black
        sLabel.text = "Sppech"
        sLabel.font = UIFont.italicSystemFont(ofSize: 16.0)
        sLabel.textAlignment = .left
        return sLabel
    } ()
    
    lazy var definitionLabel: UILabel = {
        let dLabel = UILabel()
        dLabel.translatesAutoresizingMaskIntoConstraints = false
        dLabel.textColor = .black
        dLabel.text = "Defintion"
        dLabel.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.semibold)
        dLabel.textAlignment = .left
        dLabel.numberOfLines = 4
        return dLabel
    } ()
    
    lazy var exampleLabel: UILabel = {
        let exLabel = UILabel()
        exLabel.translatesAutoresizingMaskIntoConstraints = false
        exLabel.textColor = .black
        exLabel.text = "Example"
        exLabel.font = UIFont.italicSystemFont(ofSize: 17.0)
        exLabel.textAlignment = .left
        exLabel.numberOfLines = 4
        return exLabel
    } ()
    
    lazy var favouriteButton: UIButton = {
        let favBtn = UIButton()
        favBtn.translatesAutoresizingMaskIntoConstraints = false
        favBtn.setBackgroundImage(UIImage(named: "Star"), for: .normal)
        favBtn.addTarget(self, action: #selector(favTapped(_:)), for: .touchUpInside)
        return favBtn
    } ()
    
//    lazy var menuBar: MenuBar = {
//        let mb = MenuBar()
//        mb.wordView = self
//        mb.translatesAutoresizingMaskIntoConstraints = false
//        mb.layer.cornerRadius = 3.0
//        return mb
//    }()
    
//    lazy var infoCollectionView: UICollectionView = {
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.scrollDirection = .horizontal
//        flowLayout.minimumLineSpacing = 0
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
//        cv.translatesAutoresizingMaskIntoConstraints = false
//        cv.delegate = self
//        cv.dataSource = self
//        return cv
//    }()
    
    //MARK: Info CollectionView Functions, Delegate and Datasource
//    func scrollToMenuIndex(menuIndex: Int) {
//        let indexPath = IndexPath(item: menuIndex, section: 0)
//        infoCollectionView.scrollToItem(at: indexPath, at: [], animated: true)
//    }
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 3
//    }
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let index = targetContentOffset.pointee.x / infoCollectionView.frame.width
//        let indexPath = IndexPath(item: Int(index), section: 0)
//        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
//    }
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 3
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        var sarCellIdentifer: String
//
//        if indexPath.item == 1 {
//            sarCellIdentifer = antCellID
//        } else if indexPath.item == 2 {
//            sarCellIdentifer = rhyCellID
//        } else {
//            sarCellIdentifer = synCellID
//        }
//        let cell = infoCollectionView.dequeueReusableCell(withReuseIdentifier: sarCellIdentifer, for: indexPath)
//        cell.layer.borderColor = UIColor(red: 71/255, green: 117/255, blue: 225/255, alpha: 1.0).cgColor
//        cell.layer.borderWidth = 0.75
//        return cell
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
//    }

  
    

    
}
