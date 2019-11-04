//
//  MostEmailedTableViewController.swift
//  NYTimes
//
//  Created by Eduard Galchenko on 11/3/19.
//  Copyright © 2019 Eduard Galchenko. All rights reserved.
//

import UIKit

class MostEmailedTableViewController: UITableViewController {

    let nyTimesURL = "https://api.nytimes.com/svc/mostpopular/v2/emailed/7.json?api-key=6JkXjYKKBZFPOSAoFcEL81KcVdZB6dL3"
    var articles = [Article]()
    var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Most Emailed"

        title = "Most Emailed"
        view.backgroundColor = .yellow

        // Activity indicator
        self.activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        self.activityIndicator.color = UIColor .blue
        view.addSubview(activityIndicator)
        self.activityIndicator.center = self.tableView.center
        self.activityIndicator.startAnimating()
    }

}
