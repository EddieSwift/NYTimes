//
//  MostEmailedTableViewController.swift
//  NYTimes
//
//  Created by Eduard Galchenko on 11/3/19.
//  Copyright © 2019 Eduard Galchenko. All rights reserved.
//

import UIKit

class MostEmailedTableViewController: UITableViewController {

    var articles = [Article]()
    private let apiUrl = "https://api.nytimes.com/svc/mostpopular/v2/emailed/7.json?api-key=6JkXjYKKBZFPOSAoFcEL81KcVdZB6dL3"

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Most Emailed"

        title = "Most Emailed"
        view.backgroundColor = .yellow
    }

}
