//
//  FavoritesTableViewController.swift
//  NYTimes
//
//  Created by Eduard Galchenko on 11/3/19.
//  Copyright © 2019 Eduard Galchenko. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    
    let coreDataService = CoreDataService.shared
    private var allSavedArticles = [SavedArticle]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Favorite News"
        ArticleTableViewCell.register(in: tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        allSavedArticles = coreDataService.fetchAllArticles()
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showArticleSegue" {
            
            if let showArticleViewController = segue.destination as? ShowArticleViewController {
                let indexPath = self.tableView.indexPathForSelectedRow
                let savedArticle = self.allSavedArticles[(indexPath?.row)!]
                showArticleViewController.savedArticle = savedArticle
                showArticleViewController.showTitle = "Saved Article"
            }
        }
    }
    
}

extension FavoritesTableViewController {
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allSavedArticles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ArticleTableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.identifier, for: indexPath) as! ArticleTableViewCell
        
        let article = allSavedArticles[indexPath.row]
        cell.configureWithSaved(article: article)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showArticleSegue", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.rowHeight
    }
    
}
