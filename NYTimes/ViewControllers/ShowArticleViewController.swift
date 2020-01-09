//
//  ShowArticleViewController.swift
//  NYTimes
//
//  Created by Eduard Galchenko on 05.11.2019.
//  Copyright © 2019 Eduard Galchenko. All rights reserved.
//

import UIKit
import WebKit

class ShowArticleViewController: UIViewController, WKNavigationDelegate {
    
    // MARK: - Properties and Outlets
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let coreDataService = CoreDataService.shared
    var showTitle: String!
    var article: Article!
    var savedArticle: SavedArticle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = showTitle
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        
        if let webArticle = article {
            webView.load(URLRequest(url: webArticle.url))
        } else if let webArticle = savedArticle {
            webView.load(URLRequest(url: URL(string: webArticle.url!)!))
        }
        
        webView.allowsBackForwardNavigationGestures = true
    }
    
    // MARK: - WKNavigationDelegate
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
        print(error.localizedDescription)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
        print(error.localizedDescription)
    }
    
    // MARK: - Actions
    
    @IBAction func addTapped(_ sender: UIBarButtonItem) {
        coreDataService.save(article)
        savedArticleAlert()
    }
    
    // MARK: - Alert method
    
    private func savedArticleAlert() {
        let alert = UIAlertController(title: "Success",
                                      message: "This Article Saved To Favorites",
                                      preferredStyle: .alert)
        
        let cancleAction = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(cancleAction)
        present(alert, animated: true)
    }
    
}
