//
//  WordObj.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-27.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import Foundation

struct WordObj: Decodable {
    
    let word: String?
    let results: [Results]
    let syllables: Syllables
    let pronunciation: Pronunciation
}

struct Results: Decodable {
    
    let definition: String?
    let partOfSpeech: String?
    let synonyms: [String]?
  //  let typeOf: [String]?
  //  let hasTypes: [String]?
  //  let verbGroups: [String]?
  //  let similarTo: [String]?
  //  let derivation: [String]?
    let examples: [String]?
}

struct Syllables: Decodable {
    
    let count: Int?
    let list: [String]?
}

struct Pronunciation: Decodable {
    
    let all: String?
}
