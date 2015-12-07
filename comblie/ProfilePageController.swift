//
//  SocialFeedsViewController.swift
//  comblie
//
//  Created by Cal on 10/13/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class ProfilePageController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var feedViewContainer: UIView!
    @IBOutlet weak var networkName: UILabel!
    @IBOutlet weak var customPageControls: UIStackView!
    @IBOutlet weak var headerBackground: UIView!
    
    
    var pageViewController : UIPageViewController!
    var pages : NSArray!
    var pageQuery : String!
    var viewControllers : NSArray!
    var dotCollection : [UIView]!
    var headerColor : UIColor!
    var clickedColor : UIColor!
    var notClickedColor : UIColor!
    
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
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SocialPageViewController") as! UIPageViewController
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        let facebookVC = createViewController("FacebookProfile")
        let twitterVC = createViewController("TwitterProfile")
        let instagramVC = createViewController("InstagramProfile")
        let tumblrVC = createViewController("TumblrProfile")
        let vineVC = createViewController("VineProfile")
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
        changeHeaderColors("Combined", networkIndex: 0)
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
        let currentPage = pageViewController.viewControllers?.last
        let currentIndex = pages.indexOfObject(currentPage!)
        changeHeaderColors("", networkIndex: currentIndex)
        
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
    
    func changeHeaderColors(networkID: String, networkIndex: Int) {
        
        switch networkID {
            case "Facebook":
                headerColor = UIColor(red: 63/255, green: 88/255, blue: 151/255, alpha: 1)
                clickedColor = UIColor(red: 99/255, green: 122/255, blue: 181/255, alpha: 1)
                notClickedColor = UIColor(red: 218/255, green: 239/255, blue: 250/255, alpha: 1)
                break
            case "Twitter":
                headerColor = UIColor(red: 82/255, green: 176/255, blue: 236/255, alpha: 1)
                clickedColor = UIColor(red: 118/255, green: 195/255, blue: 247/255, alpha: 1)
                notClickedColor = UIColor(red: 238/255, green: 243/255, blue: 249/255, alpha: 1)
                break
            case "Instagram":
                headerColor = UIColor(red: 49/255, green: 96/255, blue: 132/255, alpha: 1)
                clickedColor = UIColor(red: 88/255, green: 129/255, blue: 165/255, alpha: 1)
                notClickedColor = UIColor(red: 155/255, green: 179/255, blue: 201/255, alpha: 1)
                break
            case "Tumblr":
                headerColor = UIColor(red: 54/255, green: 70/255, blue: 93/255, alpha: 1)
                clickedColor = UIColor(red: 94/255, green: 106/255, blue: 125/255, alpha: 1)
                notClickedColor = UIColor(red: 140/255, green: 149/255, blue: 161/255, alpha: 1)
                break
            case "Vine":
                headerColor = UIColor(red: 105/255, green: 214/255, blue: 187/255, alpha: 1)
                clickedColor = UIColor(red: 150/255, green: 238/255, blue: 217/255, alpha: 1)
                notClickedColor = UIColor(red: 193/255, green: 245/255, blue: 233/255, alpha: 1)
                break
            default:
                headerColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
                clickedColor = UIColor(red: 49/255, green: 49/255, blue: 49/255, alpha: 1.0)
                notClickedColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1.0)
                break
        }
        
        // Change the colors
        
        self.headerBackground.backgroundColor = headerColor
        
        for (index, element) in dotCollection.enumerate() {
            if index == networkIndex {
                element.backgroundColor = clickedColor
            } else {
                element.backgroundColor = notClickedColor
            }
        }
        
        
    }
    
    
    func stylePageControls() {
        for dots in dotCollection {
            dots.layer.cornerRadius = dots.frame.height/2
        }
        
        //var currentIndex = pages.indexOfObject(viewControllers[0])
    }
    
}