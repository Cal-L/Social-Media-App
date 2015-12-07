//
//  TwitterFeedDatasource.swift
//  comblie
//
//  Created by Cal on 11/16/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class TwitterFeedDatasource: NSObject, UITableViewDataSource {
    
    var tableView : UITableView
    var items : NSMutableArray
    var isProfile : Bool
    var parent : UITableViewController
    
    init(parent: UITableViewController, tableView : UITableView, isProfile: Bool) {
        self.parent = parent
        self.isProfile = isProfile
        self.items = ["a","a", "a"]
        self.tableView = tableView
        self.tableView.registerNib(UINib(nibName: "TwitterHeaderCell", bundle: nil), forCellReuseIdentifier: "TwitterHeader")
        self.tableView.registerNib(UINib(nibName: "TwitterTweetCell", bundle: nil), forCellReuseIdentifier: "TwitterTweet")
        self.tableView.registerNib(UINib(nibName: "TwitterPhotoCell", bundle: nil), forCellReuseIdentifier: "TwitterPhoto")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var currentCell : UITableViewCell!
        
        // Configure the cell...
        if (isProfile && indexPath.row == 0) {
            currentCell = tableView.dequeueReusableCellWithIdentifier("TwitterHeader", forIndexPath: indexPath)
        } else if (indexPath.row == 1) {
            let cell = tableView.dequeueReusableCellWithIdentifier("TwitterPhoto", forIndexPath: indexPath) as! TwitterPhotoCellController
            cell.parent = self.parent
            currentCell = cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("TwitterTweet", forIndexPath: indexPath) as! TwitterTweetCellController
            //cell.retweetTextHeight.constant = CGFloat(0)
            //cell.val = 2
            //cell.parent = self.superclass
            //cell.row = indexPath
            cell.parent = self.parent
            currentCell = cell
        }
        
        return currentCell
    }
}
