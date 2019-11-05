//
//  SavedArticle+CoreDataProperties.swift
//  NYTimes
//
//  Created by Eduard Galchenko on 05.11.2019.
//  Copyright © 2019 Eduard Galchenko. All rights reserved.
//

import CoreData

extension SavedArticle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedArticle> {
        return NSFetchRequest<SavedArticle>(entityName: "SavedArticle")
    }

    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var image: String?
    @NSManaged public var url: String?
    @NSManaged public var identifier: String?

    func toArticle() -> Article {
        return Article(title: title, image: image, desc: desc, url: URL(string: url))
    }

}
