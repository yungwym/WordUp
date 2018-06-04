//
//  Models.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-01.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import Foundation


struct WordEntry {
    
    struct FullWordInfo: Decodable {
        
        let id: Int
        let word: String
        let publishDate: String
        let note: String
        let examples: [WordExamples]
        let definitions: [WordDefintions]
    }
    
    struct WordExamples: Decodable {
        
        let url: String
        let text: String
        let id: Int
        let title: String
    }
    
    struct WordDefintions: Decodable  {
        
        let text: String
        let source: String
        let partOfSpeech: String
    }
}

struct PronounceEntry: Decodable {
    
    let rawType: String
    let seq: Int
    let raw: String
}

struct NetworkRequests {
    
    //MARK: RequestWOTD
    
    static func requestWOTD(_ completionHandler: @escaping (WordEntry.FullWordInfo) -> ()) {
        
        
        let yearNum = arc4random_uniform(10) + 10
        let monthNum = arc4random_uniform(05) + 1
        let dayNum = arc4random_uniform(29) + 1
        
        let monthS = String(format: "%02d", arguments: [monthNum])
        let DayS = String(format: "%02d", arguments: [dayNum])
        
        let randomDate = ("20\(yearNum)-\(monthS)-\(DayS)")
        
        print("DATE: \(randomDate)")
        
        let apiKey = "6fd0c45761938ff99e50102bd8e0939ff52853333bc6e34e9"
        let components = URLComponents(string: "https://api.wordnik.com/v4/words.json/wordOfTheDay?date=\(randomDate)&api_key=\(apiKey)")!
        var request = URLRequest(url: components.url!)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        _ = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
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
            
            guard let wordInfo = try? JSONDecoder().decode(WordEntry.FullWordInfo.self, from: data) else {
                print("The data returned was not JSON")
                return
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                completionHandler(wordInfo)
            })
            
            print(wordInfo.word)
            print(wordInfo.id)
            print(wordInfo.examples[0].text)
            print(wordInfo.definitions[0].text)
            
            
        }).resume()
        
    }
    
    
    //MARK: RequestPronounce
    
    
    
    static func requestPronounce(_ completionHandler: @escaping ([PronounceEntry])->()) {
        
        let apiKey = "6fd0c45761938ff99e50102bd8e0939ff52853333bc6e34e9"
        let components = URLComponents(string: "https://api.wordnik.com/v4/word.json/fallacious/pronunciations?useCanonical=false&typeFormat=ahd&limit=50&api_key=\(apiKey)")!
        var request = URLRequest(url: components.url!)
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
            
            guard let pronounceInfo = try? JSONDecoder().decode([PronounceEntry].self, from: data) else {
                print("The data returned for Pronounce Request was not JSON")
                return
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                completionHandler(pronounceInfo)
                
            })
            
            print(pronounceInfo[0].raw)
            
            
        }).resume()
        
    }

}
