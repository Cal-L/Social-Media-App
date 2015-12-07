//
//  VineFeedDatasource.swift
//  comblie
//
//  Created by Cal on 11/16/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class VineFeedDatasource: NSObject, UITableViewDataSource {
    
    var tableView : UITableView
    var items : NSMutableArray
    
    var isProfile : Bool
    
    init(tableView : UITableView, isProfile : Bool) {
        self.isProfile = isProfile
        self.items = ["a","a"]
        self.tableView = tableView
        self.tableView.registerNib(UINib(nibName: "VineFeedCell", bundle: nil), forCellReuseIdentifier: "VineFeed")
        self.tableView.registerNib(UINib(nibName: "VineHeaderCell", bundle: nil), forCellReuseIdentifier: "VineHeader")
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
            currentCell = tableView.dequeueReusableCellWithIdentifier("VineHeader", forIndexPath: indexPath)
        } else {
            currentCell = tableView.dequeueReusableCellWithIdentifier("VineFeed", forIndexPath: indexPath) as! VineFeedCellController
        }
        
        return currentCell
    }
}
