//
//  WebViewController.swift
//  JobFinder
//
//  Created by Rana Alhaj on 2/9/19.
//  Copyright © 2019 ProgressSoft. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet var webView : UIWebView!
    
    var urlStr : String!
    override func viewDidLoad() {
        super.viewDidLoad()

        //load webview by passed url
        loadForWebView()
       
    }
    
    
    func loadForWebView(){
        if (urlStr == nil){
            return
        }
        
        let url = URL (string: urlStr)
        let requestObj = URLRequest(url: url!)
        webView.loadRequest(requestObj)
      
        
    }

   
}
