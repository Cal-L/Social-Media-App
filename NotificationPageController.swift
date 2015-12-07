//
//  SocialFeedsViewController.swift
//  comblie
//
//  Created by Cal on 10/13/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class NotificationPageController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    //MARK: Properties
    
    @IBOutlet weak var feedViewContainer: UIView!
    @IBOutlet weak var networkName: UILabel!
    @IBOutlet weak var customPageControls: UIStackView!
    
    
    var pageViewController : UIPageViewController!
    var pages : NSArray!
    var pageQuery : String!
    var viewControllers : NSArray!
    var dotCollection : [UIView]!
    
    // Set up for parameters that can be passed in
    init(page : String)
    {
        self.pageQuery = page
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.pageQuery = ""
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        // Instantiate the view page controller and add it to the Main View as a child view
        // Prepares the login-type views
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("NotificationPageViewController") as! UIPageViewController
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        let facebookVC = createViewController("NotificationTableView")
        let twitterVC = createViewController("NotificationTableView")
        let instagramVC = createViewController("NotificationTableView")
        let tumblrVC = createViewController("NotificationTableView")
        let vineVC = createViewController("NotificationTableView")
        pages = NSArray(objects: facebookVC, twitterVC, instagramVC, tumblrVC, vineVC)
        viewControllers = NSArray(object: facebookVC)
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
        self.addChildViewController(self.pageViewController)
        self.pageViewController.view.frame = CGRect(x: 0, y: 0, width: self.feedViewContainer.frame.width, height: self.feedViewContainer.frame.height)
        self.feedViewContainer.addSubview(self.pageViewController.view)
        //self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        dotCollection = customPageControls.subviews
        
        // Position Page Control
        initializeConstraints()
        stylePageControls()
    }
    
    //MARK: Actions
    
    
    // Creates and returns view controllers by storyboard ID
    
    func createViewController(identifierID : String) -> UIViewController {
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier(identifierID) as UIViewController
        return vc
    }
    
    // MARK: Page View Controller Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let vc = viewController as UIViewController
        var index = pages.indexOfObject(vc)
        if (index == 0 || index == NSNotFound) {
            return nil
        }
        index--
        return pages[index] as! UIViewController
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let vc = viewController as UIViewController
        var index = pages.indexOfObject(vc)
        if (index == pages.count-1 || index == NSNotFound) {
            return nil
        }
        index++
        return pages[index] as! UIViewController
        
    }
    
    // Triggers after it has landed on a new page after swipe
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        // Set the current page
        networkName.text = pageViewController.viewControllers?.last?.restorationIdentifier
        
        let currentIndex = pages.indexOfObject((pageViewController.viewControllers?.last)!)
        for (index, element) in dotCollection.enumerate() {
            if index == currentIndex {
                element.alpha = CGFloat(1.0)
            } else {
                element.alpha = CGFloat(0.25)
            }
        }
        
    }
    
    // MARK : Other
    
    func initializeConstraints() {
        let screenHeight = UIScreen.mainScreen().bounds.height
        if (screenHeight <= 480) {
            print("iPhone4")
            
        } else if screenHeight == 568 {
            print("iPhone5")
            
        } else {
            print("iPhone6")
            
        }
    }
    
    func stylePageControls() {
        for dots in dotCollection {
            dots.layer.cornerRadius = dots.frame.height/2
            dots.alpha = CGFloat(0.25)
        }
        
        var currentIndex = pages.indexOfObject(viewControllers[0])
        dotCollection[currentIndex].alpha = CGFloat(1.0)
    }
    
}