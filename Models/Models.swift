//
//  Models.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-01.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import Foundation


//MARK: WOTD Required Info

//struct WOTDData {
//
//    var word: String
//    var pronunce: String
//    var speech: String
//    var def: String
//    var ex: String
//
//    var synonyms: [String]
//    var antnoyms: [String]
//    var ryhmes: [String]
//}

//MARK: WordEntry Model

struct WordEntry: Decodable {
    
    let word: String?
    let results: [Results]
    let syllables: Syllables
    let pronunciation: Pronunciation
}

struct Results: Decodable {
    
    let definition: String?
    let partOfSpeech: String?
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

//MARK: Antonym Model

struct AntonymInfo: Decodable {
    
    let word: String
    let antonyms: [String]
}

//MARK: Ryhmes Model

struct RhymesInfo: Decodable {
    
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


//MARK: NetworkRequest

struct NetworkRequests {
    
    //Word of the Day Request
    
    static func requestWORDSAPI(forWord word: String, _ completionHandler: @escaping (WordEntry)->()) {
        
        let components = URLComponents(string: "https://wordsapiv1.p.mashape.com/words/\(word)")!
        var request = URLRequest(url: components.url!)
        request.addValue("JXuuklnEvemshF7QDEe9fdVTg8Gnp15UX1ljsnAhWmIUaJYjBt", forHTTPHeaderField: "X-Mashape-Key")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        _ = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode == 200 else {
             //print("An error occured, problem with the status code")
                
            print("!!!!!!ERROR \(word) !!!!!!!")
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
               // print("The data returned for Word Request was not JSON")
                print("!!!!!!NO JSON FOR WORD: \(word)!!!!!!!!!!!")
                
                return
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                completionHandler(wordDetails)
                
            })
            
            print(" MODEL:\(wordDetails.word ?? "Nothing")")
            print("\(components)")
            
        }).resume()
        
                
    }
    
    
    // Antnoyms Request
    
    static func requestAntnoyms(forWord word: String, _ completionHandler: @escaping (AntonymInfo)->()) {
        
        let components = URLComponents(string: "https://wordsapiv1.p.mashape.com/words/\(word)/antonyms")!
        var request = URLRequest(url: components.url!)
        request.addValue("JXuuklnEvemshF7QDEe9fdVTg8Gnp15UX1ljsnAhWmIUaJYjBt", forHTTPHeaderField: "X-Mashape-Key")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        _ = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode == 200 else {
                //print("An error occured, problem with the status code")
                
                print("!!!!!!ERROR \(word) !!!!!!!")
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
            
            guard let antonymsList = try? JSONDecoder().decode(AntonymInfo.self, from: data) else {
                // print("The data returned for Word Request was not JSON")
                print("!!!!!!NO ANTONYMS FOR: \(word)!!!!!!!!!!!")
                
                return
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                completionHandler(antonymsList)
                
            })
            
            print(components)
            
        }).resume()
        
    }
    
    
    //Ryhmes Request
    
    static func requestRhymes(forWord word: String, _ completionHandler: @escaping (RhymesInfo)->()) {
        
        let components = URLComponents(string: "https://wordsapiv1.p.mashape.com/words/\(word)/rhymes")!
        var request = URLRequest(url: components.url!)
        request.addValue("JXuuklnEvemshF7QDEe9fdVTg8Gnp15UX1ljsnAhWmIUaJYjBt", forHTTPHeaderField: "X-Mashape-Key")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        _ = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode == 200 else {
                //print("An error occured, problem with the status code")
                
                print("!!!!!!ERROR \(word) !!!!!!!")
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
            
            guard let rhymesList = try? JSONDecoder().decode(RhymesInfo.self, from: data) else {
                // print("The data returned for Word Request was not JSON")
                print("!!!!!!NO Rhymes FOR: \(word)!!!!!!!!!!!")
                print(components)
                
                return
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                completionHandler(rhymesList)
                
            })
            
            print(components)
            
        }).resume()
        
    }


}

    

    

    

    
    

