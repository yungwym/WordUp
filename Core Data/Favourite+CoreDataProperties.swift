//
//  Favourite+CoreDataProperties.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-06-20.
//  Copyright © 2018 Sav Inc. All rights reserved.
//
//

import Foundation
import CoreData


extension Favourite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favourite> {
        return NSFetchRequest<Favourite>(entityName: "Favourite")
    }

    @NSManaged public var word: String?
    @NSManaged public var speech: String?
    @NSManaged public var pronunce: String?
    @NSManaged public var definition: String?
    @NSManaged public var example: String?
    @NSManaged public var synonyms: [String]?
    @NSManaged public var antonyms: [String]?
    @NSManaged public var rhymes: [String]?

}
