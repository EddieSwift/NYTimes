//
//  MostEmailedTableViewController.swift
//  NYTimes
//
//  Created by Eduard Galchenko on 11/3/19.
//  Copyright © 2019 Eduard Galchenko. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

let rowHeight: CGFloat = 120.0

class MostEmailedTableViewController: UITableViewController {

    // MARK: - Properties

    let mostEmailedURL = "emailed/7.json?api-key=6JkXjYKKBZFPOSAoFcEL81KcVdZB6dL3"
    var articles = [Article]()
    var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Most Emailed"

        setupActivityIndicator()

        ArticleTableViewCell.register(in: tableView)

        getArticles()
    }

    // MARK: - Network Method

    private func getArticles() {
        startAnimation()
        NetworkService.shared.getArticles(mostEmailedURL) { [weak self] state in
            guard let `self` = self else { return }
            switch state {
            case .success(let articles):
                self.articles = articles
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .error(let error):
                print(error.localizedDescription)
            }
            self.stopAnimation()
        }
    }

    // MARK: - SetupUI

    private func setupActivityIndicator() {
        self.activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        self.activityIndicator.color = UIColor .blue
        view.addSubview(activityIndicator)
        self.activityIndicator.center = view.center
    }

    // MARK: - Indicator Methods

    private func startAnimation() {
        activityIndicator.startAnimating()
    }

    private func stopAnimation() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "sendUrlSegue" {
//
//            if let viewController = segue.destination as? DetailedViewController {
//                let indexPath = self.tableView.indexPathForSelectedRow
//                let article = self.articles[(indexPath?.row)!]
//                viewController.url = article.url
//            }
//        }
//    }

}

extension MostEmailedTableViewController {

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = Bundle.main.loadNibNamed("ArticleTableViewCell", owner: self, options: nil)?.first as! ArticleTableViewCell

        let article = self.articles[indexPath.row]
        cell.configureWith(article: article)

        return cell
    }

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.performSegue(withIdentifier: "sendUrlSegue", sender: self)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }

}
