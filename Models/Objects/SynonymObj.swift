//
//  SynonymObj.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-27.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import Foundation

struct SynonymObj: Decodable {
    
    let word: String
    let synonyms: [String]
}
