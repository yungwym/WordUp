//
//  PersistenceService.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-20.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import Foundation
import CoreData

class PersistenceService {

    var nsObj = NSManagedObject()
    // MARK: - Core Data stack
    
    private init() {}
    
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "WordUp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    //Create Favourite
    static func createFavourite(wordObj: WordObj) {
        
        let fav = Favourite(context: context)
        
        fav.word = wordObj.word
        fav.speech = wordObj.results[0].partOfSpeech
        fav.pronunce = wordObj.pronunciation.all
        fav.definition = wordObj.results[0].definition
        //  fav.example = wordEntry?.results[0].examples![0]
        saveContext()
    }
   
    //Fetch Favourite with word Perdicate
    static func fetchWithPredicate(word: String)-> Favourite? {
        
        let fetchRequest = NSFetchRequest<Favourite>(entityName: "Favourite")
        let predicate = NSPredicate(format: "word == %@", word)
        fetchRequest.predicate = predicate
        let word = try! context.fetch(fetchRequest)
        guard let returnedWord = word.first else { return nil}
        print(returnedWord.word!)
        return returnedWord
    }
    
    //Delete Favourite
    static func delete(favourite: Favourite) {
        context.delete(favourite)
        print("Deleted \(String(describing: favourite.word))")
        saveContext()
    }
    
    
    
    //Save 
    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("SAVED")
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
