//
//  DetailViewController.swift
//  Whitehouse Petitions
//
//  Created by Alisher Abdukarimov on 6/28/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var webView: WKWebView!
    var detailItem: [String: String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView()
        view = webView
        
        guard detailItem != nil  else {
            return
        }
        
        if let body = detailItem["body"] {
        var html = "<html>"
        html += "<head>"
        html += "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"
        html += "<style> body { font-size: 150%; } </style>"
        html += "</head>"
        html += "<body>"
        html += body
        html += "</body>"
        html += "</html>"
        webView.loadHTMLString(html, baseURL: nil)
    }
        
        
        
    }

}
