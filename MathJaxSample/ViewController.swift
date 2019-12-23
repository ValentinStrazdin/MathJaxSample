//
//  ViewController.swift
//  MathJaxSample
//
//  Created by Strazdin, Valentin on 11/09/2019.
//  Copyright © 2019 Strazdin, Valentin. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    @IBOutlet weak var elapsedTimeLabel: UILabel!
    var startTime: Date?
    let formula = "\\[\\int_{\\mathbb{R}} P_n(\\lambda)P_m(\\lambda)w(\\lambda)d\\lambda = h_n{\\delta}_{nm},\\]"
    let formula_Tag = "~|%Formula%|~"
    
    private var webView: WKWebView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Do any additional setup after loading the view.
        self.webView = WKWebView()
        self.webView.frame = view.frame
        self.webView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.webView.navigationDelegate = self
        self.view.addSubview(webView)
        self.view.sendSubviewToBack(webView)
        
    }

    @IBAction func katexSelected(_ sender: UIButton) {
        guard let url = Bundle.main.url(forResource: "Katex/katex_base", withExtension: "html") else {
            print("File not found: Katex/katex_base.html")
            return
        }
        do {
            var htmlString = try String(contentsOfFile: url.path, encoding: String.Encoding.utf8)
            htmlString = htmlString.replacingOccurrences(of: formula_Tag, with: formula)
            webView.loadHTMLString(htmlString, baseURL: url)
        } catch {
            print("Error loading file contents: \(error.localizedDescription)")
        }
    }
    
    @IBAction func mathJaxSelected(_ sender: UIButton) {
        guard let url = Bundle.main.url(forResource: "MathJax/mathJax_base", withExtension: "html") else {
            print("File not found: MathJax/mathJax_base.html")
            return
        }
        // Both following methods work fine
//        webView.loadFileURL(url, allowingReadAccessTo: url)
//        let request = URLRequest(url: url)
//        webView.load(request)
        do {
            var htmlString = try String(contentsOfFile: url.path, encoding: String.Encoding.utf8)
            htmlString = htmlString.replacingOccurrences(of: formula_Tag, with: formula)
            webView.loadHTMLString(htmlString, baseURL: url)
        } catch {
            print("Error loading file contents: \(error.localizedDescription)")
        }
    }
}

extension ViewController: WKNavigationDelegate {
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        self.startTime = Date()
        Logging.logMessage("Start loading page")
        decisionHandler(.allow)
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let startTime = startTime {
            let elapsedTime: TimeInterval = -startTime.timeIntervalSinceNow
            let formatted = String(format: "Elapsed time: %.2f", elapsedTime)
            Logging.logMessage(formatted)
            elapsedTimeLabel.text = formatted
        }
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        Logging.logMessage("Error loading page: \(error.localizedDescription)")
    }
}
