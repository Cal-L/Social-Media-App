//
//  AllFeedDatasource.swift
//  comblie
//
//  Created by Cal on 11/16/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class AllFeedDatasource: NSObject, UITableViewDataSource {
    
    var tableView : UITableView
    var items : NSMutableArray
    var parent : UITableViewController
    
    init(tableView : UITableView, parent : UITableViewController) {
        self.items = ["a","a", "a","a"]
        self.parent = parent
        self.tableView = tableView
        self.tableView.registerNib(UINib(nibName: "VineFeedCell", bundle: nil), forCellReuseIdentifier: "VineFeed")
        self.tableView.registerNib(UINib(nibName: "TwitterTweetCell", bundle: nil), forCellReuseIdentifier: "TwitterTweet")
        self.tableView.registerNib(UINib(nibName: "TumblrPhotoCell", bundle: nil), forCellReuseIdentifier: "TumblrPhoto")
        self.tableView.registerNib(UINib(nibName: "InstagramFeedCell", bundle: nil), forCellReuseIdentifier: "InstagramFeed")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Configure the cell...
        
        var cell : UITableViewCell!
        if (indexPath.row == 1) {
            cell = tableView.dequeueReusableCellWithIdentifier("VineFeed", forIndexPath: indexPath)
        } else if (indexPath.row == 0) {
            let currentCell = tableView.dequeueReusableCellWithIdentifier("TwitterTweet", forIndexPath: indexPath) as! TwitterTweetCellController
            currentCell.retweetTextHeight.constant = CGFloat(0)
            currentCell.parent = self.parent
            cell = currentCell
        } else if (indexPath.row == 2) {
            cell = tableView.dequeueReusableCellWithIdentifier("TumblrPhoto", forIndexPath: indexPath)
        } else if (indexPath.row == 3) {
            cell = tableView.dequeueReusableCellWithIdentifier("InstagramFeed", forIndexPath: indexPath)
        }
        // Configure the cell...
        return cell
    }
}
