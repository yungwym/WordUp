//
//  Models.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-01.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import Foundation


//MARK: WordEntry Model

struct WordEntry: Decodable {
    
    let word: String
    let results: [Results]
    let syllables: Syllables
    let pronunciation: Pronunciation
}

struct Results: Decodable {
    
    let definition: String
    let partOfSpeech: String
    let synonyms: [String]?
    let typeOf: [String]?
    let hasTypes: [String]?
    let verbGroups: [String]?
    let similarTo: [String]?
    let derivation: [String]?
    let examples: [String]?
}

struct Syllables: Decodable {
    
    let count: Int?
    let list: [String]?
}

struct Pronunciation: Decodable {
    
    let all: String?
}



//MARK: NetworkRequest

struct NetworkRequests {
    
    
    
    static func requestWORDSAPI(forWord word: String, _ completionHandler: @escaping (WordEntry)->()) {
        
        let components = URLComponents(string: "https://wordsapiv1.p.mashape.com/words/\(word)")!
        var request = URLRequest(url: components.url!)
        request.addValue("JXuuklnEvemshF7QDEe9fdVTg8Gnp15UX1ljsnAhWmIUaJYjBt", forHTTPHeaderField: "X-Mashape-Key")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        _ = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode == 200 else {
                print("An error occured, problem with the status code")
                return
            }
            
            guard error == nil else {
                print(#line, error!.localizedDescription)
                print(NSString.init(data: data!, encoding: String.Encoding.utf8.rawValue)!)
                return
            }
            
            guard let data = data else {
                print("No data was returned")
                return
            }
            
            guard let wordDetails = try? JSONDecoder().decode(WordEntry.self, from: data) else {
                print("The data returned for Word Request was not JSON")
                return
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                completionHandler(wordDetails)
                
            })
            
            print(wordDetails.word)
            print(wordDetails.results[0].definition)
            print(wordDetails.results[0].partOfSpeech)
            print(wordDetails.results[0].synonyms)
            print(wordDetails.pronunciation.all)
            
        }).resume()
        
    }
    
    
}
    

    

    

    

    
    

