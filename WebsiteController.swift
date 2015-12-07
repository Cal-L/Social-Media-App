//
//  WebsiteController.swift
//  comblie
//
//  Created by Cal on 11/11/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class WebsiteController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var topSeparatorHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomSeparatorHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.topSeparatorHeight.constant = CGFloat(0.5)
        self.bottomSeparatorHeight.constant = CGFloat(0.5)
        
        let URL = NSURL(string: "http://www.comblie.com")
        let requestObj = NSURLRequest(URL: URL!)
        self.webView.loadRequest(requestObj)
    }

    //MARK: Actions
    
    @IBAction func cancel(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func webBack(sender: UIButton) {
        if self.webView.canGoBack == true {
            self.webView.goBack()
        }
    }
    
    @IBAction func webForward(sender: UIButton) {
        if self.webView.canGoForward == true {
            self.webView.goForward()
        }
    }

    @IBAction func webRefresh(sender: UIButton) {
        self.webView.reload()
    }
    
    @IBAction func webUpload(sender: UIButton) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
