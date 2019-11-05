//
//  CoreDataService.swift
//  NYTimes
//
//  Created by Eduard Galchenko on 11/3/19.
//  Copyright © 2019 Eduard Galchenko. All rights reserved.
//

import CoreData

final public class CoreDataService {

    public static let shared = CoreDataService()

    private var backgroundContext: NSManagedObjectContext!

    init() {
        createContainer { container in
            self.backgroundContext = container.newBackgroundContext()
        }
    }

    func fetchAllArticles() -> [SavedArticle] {
        let fetchRequest =
            NSFetchRequest<NSFetchRequestResult>(entityName: "SavedArticle")
        do {
            guard let articles = try backgroundContext
                .fetch(fetchRequest) as? [SavedArticle] else { return [SavedArticle]() }
            return articles
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return [SavedArticle]()
    }

    public func save(_ article: Article) {
        guard let context = backgroundContext else { return }
        guard let savedArticle = NSEntityDescription.insertNewObject(forEntityName: "SavedArticle",
                                                                     into: context) as? SavedArticle else { return }
        savedArticle.title = article.title
        savedArticle.desc = article.desc
        savedArticle.image = article.image
        savedArticle.url = article.url.absoluteString
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }

    func createContainer(completion: @escaping
        (NSPersistentContainer) -> Void) { let container = NSPersistentContainer(name:
        "NYTimes")
        container.loadPersistentStores(completionHandler: { _, error in
            guard error == nil else {
                fatalError("Failed to load store")
            }
            DispatchQueue.main.async { completion(container) }
        })
    }
}
