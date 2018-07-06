//
//  DictionaryVC.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-29.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import UIKit

class DictionaryVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: Variables & Constants
    let thisCellID = "thisCellID"
    
    var wordObject: WordObj?
    
    let dispatchGroup = DispatchGroup()
    
    let dictCellID = "dictCellID"
    let favCellID = "favCellID"
    
    //MARK: Outlets
    @IBOutlet weak var secondaryBackgroundView: UIView!
    
    //MARK: Blocks
    lazy var wordView: WordView = {
        let wv = WordView()
        wv.translatesAutoresizingMaskIntoConstraints = false
        wv.layer.cornerRadius = 6.0
        return wv
    } ()
    
    
    lazy var dictMenuBar: DictionaryMenuBar = {
        let dmb = DictionaryMenuBar()
        dmb.dictionaryVC = self
        dmb.translatesAutoresizingMaskIntoConstraints = false
        dmb.layer.cornerRadius = 3.0
        return dmb
    } ()
    
    lazy var dictCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        let dVC = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        dVC.translatesAutoresizingMaskIntoConstraints = false
        dVC.delegate = self
        dVC.dataSource = self
        return dVC
    } ()
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpDictMenuBar()
        setUpDictCollectionView()
        setupWordView()
       
        secondaryBackgroundView.layer.cornerRadius = 6.0
    }
    
    //Functions
    func scrollToMenuIndex(menuIndex: Int) {
        
        let indexPath = IndexPath(item: menuIndex, section: 0)
        dictCollectionView.scrollToItem(at: indexPath, at: [], animated: true)
    }

    //MARK: Setup Views Functions
    private func setupWordView() {
        
        view.addSubview(wordView)
        wordView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        wordView.topAnchor.constraint(equalTo: view.topAnchor, constant: 25.0).isActive = true
        
        wordView.widthAnchor.constraint(equalTo: secondaryBackgroundView.widthAnchor).isActive = true
        wordView.heightAnchor.constraint(equalTo: secondaryBackgroundView.heightAnchor).isActive = true

        wordView.leadingAnchor.constraint(equalTo: secondaryBackgroundView.trailingAnchor, constant: -45.0).isActive = true
    }
    
    private func setUpDictMenuBar() {
        secondaryBackgroundView.addSubview(dictMenuBar)
        dictMenuBar.clipsToBounds = true
        dictMenuBar.centerXAnchor.constraint(equalTo: secondaryBackgroundView.centerXAnchor).isActive = true
        dictMenuBar.topAnchor.constraint(equalTo: secondaryBackgroundView.topAnchor, constant: 8.0).isActive = true
        dictMenuBar.leadingAnchor.constraint(equalTo: secondaryBackgroundView.leadingAnchor, constant: 8.0).isActive = true
        dictMenuBar.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
    }
    
    private func setUpDictCollectionView() {
        
        secondaryBackgroundView.addSubview(dictCollectionView)
        dictCollectionView.isPagingEnabled = true
        dictCollectionView.showsHorizontalScrollIndicator = false
        dictCollectionView.layer.cornerRadius = 3.0
        dictCollectionView.backgroundColor = myBlue
        
        dictCollectionView.topAnchor.constraint(equalTo: dictMenuBar.bottomAnchor, constant: 8.0).isActive = true
        dictCollectionView.bottomAnchor.constraint(equalTo: secondaryBackgroundView.bottomAnchor, constant: -8.0).isActive = true
        dictCollectionView.leadingAnchor.constraint(equalTo: dictMenuBar.leadingAnchor).isActive = true
        dictCollectionView.centerXAnchor.constraint(equalTo: secondaryBackgroundView.centerXAnchor).isActive = true
        
        dictCollectionView.register(FavouritesCell.self, forCellWithReuseIdentifier: favCellID)
        dictCollectionView.register(DictionaryCell.self, forCellWithReuseIdentifier: dictCellID)
    }
    
    //MARK: CollectionView Delegate & Datasource
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        dictMenuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 2
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.pointee.x / dictCollectionView.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        dictMenuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var identifer: String
        
        if indexPath.item == 1 {
            identifer = favCellID
        } else {
            identifer = dictCellID
        }
        
        let cell = dictCollectionView.dequeueReusableCell(withReuseIdentifier: identifer, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
