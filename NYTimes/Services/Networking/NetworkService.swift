//
//  NetworkService.swift
//  NYTimes
//
//  Created by Eduard Galchenko on 04.11.2019.
//  Copyright © 2019 Eduard Galchenko. All rights reserved.
//

import Alamofire
import SwiftyJSON

public enum NetworkResponse {
    case success(_ article: [Article])
    case error(_ error: Error)
}

public class NetworkService {
    public static let shared = NetworkService()
    public func getArticles(_ apiUrl: String, completion: @escaping (NetworkResponse) -> Void) {

        var articles = [Article]()

        Alamofire.request(Constants.NetworkURL.baseURL + apiUrl).responseJSON { response in
            if response.result.value != nil {
                let json = JSON(response.result.value!)
                let results = json["results"].arrayValue

                for result in results {
                    let article = Article(title: result["title"].stringValue, image: result["media"][0]["media-metadata"][0]["url"].stringValue, desc: result["abstract"].stringValue, url: result["url"].url!)
                        articles.append(article)
                }
                completion(.success(articles))
            } else {
                guard let error = response.error else {
                    completion(.error(response.error!))
                    return
                }
                completion(.error(error))
            }
        }
    }
}
