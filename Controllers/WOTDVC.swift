//
//  WOTDVC.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-01.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import UIKit

class WOTDVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
   
    //MARK: Variables & Constants
    var wordEntry: WordObj?
    var antonyms: AntonymObj?
    var rhymes: RhymeObj?
    
    let synCellID = "synCellID"
    let antCellID = "antCellID"
    let rhyCellID = "rhyCellID"
    
  //   let cellDolo = "cellID"
    
    //MARK: Blocks
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.wotdController = self
        mb.translatesAutoresizingMaskIntoConstraints = false
        mb.layer.cornerRadius = 3.0
        return mb
    }()
    
    lazy var infoCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    //MARK: Outlets
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var pronounceLabel: UILabel!
    @IBOutlet weak var defLabel: UILabel!
    @IBOutlet weak var exLabel: UILabel!
    @IBOutlet weak var speechLabel: UILabel!
   
    @IBOutlet weak var favButton: UIButton!
    
    @IBOutlet weak var secondaryBackgroundView: UIView!
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayWordEntry()
        
        setUpMenuBar()
        
        setupCollectionView()
        
        secondaryBackgroundView.layer.cornerRadius = 6.0
    }
    
    //MARK: Functions
    
    func scrollToMenuIndex(menuIndex: Int) {
        
        let indexPath = IndexPath(item: menuIndex, section: 0)
        infoCollectionView.scrollToItem(at: indexPath, at: [], animated: true)
    }
    
    
    private func setupCollectionView() {
        secondaryBackgroundView.addSubview(infoCollectionView)
        
        infoCollectionView.isPagingEnabled = true
        infoCollectionView.showsHorizontalScrollIndicator = false
        infoCollectionView.backgroundColor = myBlue
        //collectionView.centerYAnchor.constraint(equalTo: menuBar.centerYAnchor, constant: 40).isActive = true
        infoCollectionView.topAnchor.constraint(equalTo: menuBar.bottomAnchor, constant: 4).isActive = true
        infoCollectionView.bottomAnchor.constraint(equalTo: secondaryBackgroundView.bottomAnchor, constant: -25).isActive = true
        infoCollectionView.centerXAnchor.constraint(equalTo: menuBar.centerXAnchor).isActive = true
        infoCollectionView.leadingAnchor.constraint(equalTo: menuBar.leadingAnchor).isActive = true
        //collectionView.heightAnchor.constraint(equalToConstant: 150.0).isActive = true
        infoCollectionView.layer.cornerRadius = 3.0
        infoCollectionView.layer.borderColor = UIColor(red: 71/255, green: 117/255, blue: 225/255, alpha: 1.0).cgColor
        infoCollectionView.layer.borderWidth = 0.75
        
        infoCollectionView.register(SynonymCell.self, forCellWithReuseIdentifier: synCellID)
        infoCollectionView.register(AntonymCell.self, forCellWithReuseIdentifier: antCellID)
        infoCollectionView.register(RhymeCell.self, forCellWithReuseIdentifier: rhyCellID)
    }
    
    private func setUpMenuBar() {
        
        view.addSubview(menuBar)
        menuBar.clipsToBounds = true
        menuBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        menuBar.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 35.0).isActive = true

    }
    
    func displayWordEntry() {
        
        wordLabel.text = wordEntry?.word?.capitalized
        pronounceLabel.text = "| \(wordEntry?.pronunciation.all ?? "" ) |"
        speechLabel.text = wordEntry?.results[0].partOfSpeech
        defLabel.text = wordEntry?.results[0].definition
        
        guard let ex = wordEntry?.results[0].examples?[0] else {
            exLabel.text = ""
            print("No Example")
            return
        }
        exLabel.text = ex
    }
    
    
    //MARK: CollectionView Delegate & Datasource
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 3
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.pointee.x / infoCollectionView.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }

    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return 3
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var sarCellIdentifer: String
        
        if indexPath.item == 1 {
            sarCellIdentifer = antCellID
        } else if indexPath.item == 2 {
            sarCellIdentifer = rhyCellID
        } else {
            sarCellIdentifer = synCellID
        }
    
        let cell = infoCollectionView.dequeueReusableCell(withReuseIdentifier: sarCellIdentifer, for: indexPath)
        cell.layer.borderColor = UIColor(red: 71/255, green: 117/255, blue: 225/255, alpha: 1.0).cgColor
        cell.layer.borderWidth = 0.75
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    //MARK: Actions
    
    @IBAction func favTapped(_ sender: UIButton) {
        
        favButton.imageView?.image = UIImage(named: "Filled Star")
        
        let fav = Favourite(context: PersistenceService.context)
        
        fav.word = wordEntry?.word
        fav.speech = wordEntry?.results[0].partOfSpeech
        fav.pronunce = wordEntry?.pronunciation.all
        fav.definition = wordEntry?.results[0].definition
     //   fav.example = wordEntry?.results[0].examples![0]
        
        PersistenceService.saveContext()
    }
}
