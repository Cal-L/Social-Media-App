//
//  InstagramFeedDatasource.swift
//  comblie
//
//  Created by Cal on 11/16/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class InstagramFeedDatasource: NSObject, UITableViewDataSource {
    
    var tableView : UITableView
    var items : NSMutableArray
    
    init(tableView : UITableView) {
        self.items = ["a"]
        self.tableView = tableView
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
        var currentCell : UITableViewCell!
        if (indexPath.row == 1) {
            let cell = tableView.dequeueReusableCellWithIdentifier("InstagramFeed", forIndexPath: indexPath) as! InstagramFeedCellController
            cell.playButton.alpha = CGFloat(0)
            currentCell = cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("InstagramFeed", forIndexPath: indexPath) as! InstagramFeedCellController
            currentCell = cell
        }
        // Configure the cell...
        
        return currentCell
    }
}
