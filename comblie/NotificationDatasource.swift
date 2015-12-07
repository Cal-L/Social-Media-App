//
//  NotificationDatasource.swift
//  comblie
//
//  Created by Cal on 11/16/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class NotificationDatasource: NSObject, UITableViewDataSource {
    
    var tableView : UITableView
    var items : NSMutableArray
    
    init(tableView : UITableView) {
        self.items = ["a","a"]
        self.tableView = tableView
        self.tableView.registerNib(UINib(nibName: "NotificationCell", bundle: nil), forCellReuseIdentifier: "Notification")
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
        let cell = tableView.dequeueReusableCellWithIdentifier("Notification", forIndexPath: indexPath) as! NotificationCell
        cell.profileImage.image = UIImage(named: "profileImage")
        cell.layoutMargins = UIEdgeInsetsZero
        currentCell = cell
        return currentCell
    }
}
