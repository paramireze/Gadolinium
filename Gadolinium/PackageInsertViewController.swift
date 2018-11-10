//
//  PackageInsertController.swift
//  Gadolinium
//
//  Created by Ramirez Paul E on 11/4/18.
//  Copyright © 2018 Ramirez Paul E. All rights reserved.
//
import WebKit
import UIKit
import os.log

class PackageInsertViewController: UIViewController {
    var packageInsert: String!
    
    
    @IBOutlet weak var webView: WKWebView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for:segue, sender: sender)
        
       

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL (string: packageInsert);
        let request = NSURLRequest(url: url! as URL);
        webView.load(request as URLRequest);
        print(packageInsert)
    }
}
