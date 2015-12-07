//
//  MainViewController.swift
//  comblie
//
//  Created by Cal on 10/11/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var pageControls: UIPageControl!
    @IBOutlet weak var innerBottomSpacing: NSLayoutConstraint!
    
    var pageViewController : UIPageViewController!
    var pages : NSArray!
    var pageQuery : String!
    var viewControllers : NSArray!
    
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
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        let loginVC = self.storyboard?.instantiateViewControllerWithIdentifier("LoginPage") as! LoginViewController
        let registrationVC = self.storyboard?.instantiateViewControllerWithIdentifier("RegistrationPage") as! RegistrationViewController
        pages = NSArray(objects: loginVC, registrationVC)
        
        // Checks whether the Get started or login button was pressed
        if pageQuery == "Login" {
            viewControllers = NSArray(object: loginVC)
        } else if pageQuery == "Register" {
            viewControllers = NSArray(object: registrationVC)
        }
        
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        self.pageControls.currentPage = pages.indexOfObject(viewControllers[0])
        self.view.bringSubviewToFront(pageControls)
        
        // Position Page Control
        initializeConstraints()
    }
    
    //MARK: Actions
    
    
    // Creates and returns view controllers by storyboard ID
    
    func createViewController(identifierID : String) -> UIViewController {
        let vc: UIViewController = self.storyboard!.instantiateViewControllerWithIdentifier(identifierID) as UIViewController
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
        let currentPage = pages.indexOfObject((pageViewController.viewControllers?.last)!)
        pageControls.currentPage = currentPage
    }
    
    // MARK : Other
    
    func initializeConstraints() {
        let screenHeight = UIScreen.mainScreen().bounds.height
        if (screenHeight <= 480) {
            print("iPhone4")
            innerBottomSpacing.constant = 5
        } else if screenHeight == 568 {
            print("iPhone5")
            innerBottomSpacing.constant = 40
        } else {
            print("iPhone6")
            innerBottomSpacing.constant = 50
        }
    }
    
}