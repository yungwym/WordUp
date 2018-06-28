//
//  RhymeObj.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-27.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import Foundation

struct RhymeObj: Decodable {
    
    let word: String
    let rhymes: RhymesAll
    let pronunciation: PronunciationInfo?
}

struct RhymesAll: Decodable {
    
    let all: [String]?
}

struct PronunciationInfo: Decodable {
    
    let all: String?
    let simplified: String?
    
}

