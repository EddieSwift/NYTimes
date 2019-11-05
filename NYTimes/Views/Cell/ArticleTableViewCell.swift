//
//  ArticleTableViewCell.swift
//  NYTimes
//
//  Created by Eduard Galchenko on 11/3/19.
//  Copyright © 2019 Eduard Galchenko. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    public static let identifier = "ArticleTableViewCell"
    private static let nibName   = "ArticleTableViewCell"
    
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleDescriptionLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    
    public static func register(in tableView: UITableView) {
        let nib = UINib.init(nibName: nibName, bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }
    
    func configureWith(article: Article) {
        articleTitleLabel.text = article.title
        articleDescriptionLabel.text = article.desc
        articleImageView.loadImageInCache(with: article.image)
    }
    
    func configureWithSaved(article: SavedArticle) {
        articleTitleLabel.text = article.title
        articleDescriptionLabel.text = article.desc
        articleImageView.loadImageInCache(with: article.image!)
    }
    
}
