//
//  APIService.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-26.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import Foundation


//MARK: NetworkRequest

struct NetworkRequests {
    
    //Word of the Day Request
    
    static func requestWORDSAPI(forWord word: String, _ completionHandler: @escaping (WordObj)->()) {
        
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
            
            guard let wordDetails = try? JSONDecoder().decode(WordObj.self, from: data) else {
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
    
    
    // Synonyms Request
    
    static func requestSynonyms(forWord word: String, _ completionHandler: @escaping (SynonymObj)->()) {
        
        let components = URLComponents(string: "https://wordsapiv1.p.mashape.com/words/\(word)/synonyms")!
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
            
            guard let antonymsList = try? JSONDecoder().decode(SynonymObj.self, from: data) else {
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
    
    
    // Antnoyms Request
    
    static func requestAntnoyms(forWord word: String, _ completionHandler: @escaping (AntonymObj)->()) {
        
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
            
            guard let antonymsList = try? JSONDecoder().decode(AntonymObj.self, from: data) else {
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
    
    static func requestRhymes(forWord word: String, _ completionHandler: @escaping (RhymeObj)->()) {
        
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
            
            guard let rhymesList = try? JSONDecoder().decode(RhymeObj.self, from: data) else {
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
