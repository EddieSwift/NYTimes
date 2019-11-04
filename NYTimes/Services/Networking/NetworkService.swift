//
//  NetworkService.swift
//  NYTimes
//
//  Created by Eduard Galchenko on 11/3/19.
//  Copyright © 2019 Eduard Galchenko. All rights reserved.
//

import Alamofire
import SwiftyJSON



public enum NetworkResponse {
    case success(_ article: String)
    case error(_ error: Error)
}

protocol NetworkingServiceProvider {
    func getArticles(requestUrl: String, completion: @escaping (NetworkResponse) -> Void) -> [Article]
}

class NetworkService: NetworkingServiceProvider {
    func getArticles(requestUrl: String, completion: @escaping (NetworkResponse) -> Void) -> [Article] {

        var articles = [Article]()

        Alamofire.request(requestUrl).responseJSON { response in

            if response.result.value != nil {

                let json = JSON(response.result.value!)
                let results = json["results"].arrayValue

                for result in results {

                    let article = Article(title: result["title"].stringValue, image: result["media"][0]["media-metadata"][0]["url"].stringValue, desc: result["abstract"].stringValue, url: result["url"].url!)

                    articles.append(article)
                }

                //                DispatchQueue.main.async {
                //                    self.tableView.reloadData()
                //                }
                //
                //                self.activityIndicator.stopAnimating()
                //                self.activityIndicator.removeFromSuperview()
            }
        }

        return articles
    }

}




