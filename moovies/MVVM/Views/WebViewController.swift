//
//  WebKitViewController.swift
//  moovies
//
//  Created by Sendo Tjiam on 04/04/22.
//

import Foundation
import UIKit
import WebKit

class WebViewController : UIViewController, WKNavigationDelegate {
    
    let url : URL!
    var webView : WKWebView!
    
    init(url : URL) {
        self.url = url
        super.init(nibName: "WebKitViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
}
