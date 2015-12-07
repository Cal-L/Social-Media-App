//
//  TumblrFeedDatasource.swift
//  comblie
//
//  Created by Cal on 11/16/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class TumblrFeedDatasource: NSObject, UITableViewDataSource {
    
    var tableView : UITableView
    var items : NSMutableArray
    var isProfile : Bool
    
    init(tableView : UITableView, isProfile : Bool) {
        self.isProfile = isProfile
        self.items = ["a","a", "a"]
        self.tableView = tableView
        self.tableView.registerNib(UINib(nibName: "TumblrHeaderCell", bundle: nil), forCellReuseIdentifier: "TumblrHeader")
        self.tableView.registerNib(UINib(nibName: "TumblrBlogCell", bundle: nil), forCellReuseIdentifier: "TumblrBlog")
        self.tableView.registerNib(UINib(nibName: "TumblrPhotoCell", bundle: nil), forCellReuseIdentifier: "TumblrPhoto")
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
            currentCell = tableView.dequeueReusableCellWithIdentifier("TumblrHeader", forIndexPath: indexPath)
        } else if (indexPath.row == 1) {
            currentCell = tableView.dequeueReusableCellWithIdentifier("TumblrPhoto", forIndexPath: indexPath)
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("TumblrBlog", forIndexPath: indexPath) as! TumblrBlogCellController
            if (indexPath.row % 2 != 0) {
                cell.removeComments()
            }
            currentCell = cell
        }
        
        return currentCell
    }
}

