//
//  ConversationListDatasource.swift
//  comblie
//
//  Created by Cal on 11/16/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class ConversationListDatasource: NSObject, UITableViewDataSource {
    
    var tableView : UITableView
    var items : NSMutableArray
    
    init(tableView : UITableView) {
        self.items = ["a","a","a","a","a","a","a","a","a","a"]
        self.tableView = tableView
        self.tableView.registerNib(UINib(nibName: "ConversationCell", bundle: nil), forCellReuseIdentifier: "ConversationCell")
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
        let cell = tableView.dequeueReusableCellWithIdentifier("ConversationCell", forIndexPath: indexPath) as! ConversationCellController
        cell.profileImage.image = UIImage(named: "profileImage")
        cell.layoutMargins = UIEdgeInsetsZero
        currentCell = cell
        
        return currentCell
    }
    
}
