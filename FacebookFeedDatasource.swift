//
//  FacebookFeedDatasource.swift
//  comblie
//
//  Created by Cal on 11/16/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class FacebookFeedDatasource: NSObject, UITableViewDataSource {
    
    var tableView : UITableView
    var items : NSMutableArray
    var isProfile : Bool
    var parent : UITableViewController!
    
    init(parent: UITableViewController, tableView : UITableView, isProfile: Bool) {
        self.parent = parent
        self.isProfile = isProfile
        self.items = ["a","a", "a"]
        self.tableView = tableView
        self.tableView.registerNib(UINib(nibName: "FacebookHeaderCell", bundle: nil), forCellReuseIdentifier: "FacebookHeader")
        self.tableView.registerNib(UINib(nibName: "FacebookStatusCell", bundle: nil), forCellReuseIdentifier: "FacebookStatus")
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
            currentCell = tableView.dequeueReusableCellWithIdentifier("FacebookHeader", forIndexPath: indexPath)
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("FacebookStatus", forIndexPath: indexPath) as! FacebookStatusCellController
            cell.parent = self.parent
            currentCell = cell
        }
        
        return currentCell
    }
}
