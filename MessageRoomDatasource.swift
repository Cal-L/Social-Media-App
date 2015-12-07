//
//  MessageRoomDatasource.swift
//  comblie
//
//  Created by Cal on 11/16/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class MessageRoomDatasource: NSObject, UITableViewDataSource {
    
    var tableView : UITableView
    var items : NSMutableArray
    
    init(tableView : UITableView) {
        self.items = ["a","a","a","a","a","a","a","a"]
        self.tableView = tableView
        self.tableView.registerNib(UINib(nibName: "IncomingMessageCell", bundle: nil), forCellReuseIdentifier: "IncomingMessage")
        self.tableView.registerNib(UINib(nibName: "IncomingMessageTwoCell", bundle: nil), forCellReuseIdentifier: "IncomingMessageTwo")
        self.tableView.registerNib(UINib(nibName: "OutgoingMessageCell", bundle: nil), forCellReuseIdentifier: "OutgoingMessage")
        self.tableView.registerNib(UINib(nibName: "TimeMessageCell", bundle: nil), forCellReuseIdentifier: "TimeMessage")
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
        if(indexPath.row==0){
            // Create first cell
            let cell = tableView.dequeueReusableCellWithIdentifier("TimeMessage", forIndexPath: indexPath) as! TimeMessageCellController
            cell.timeLabel.text = "YESTERDAY 5:02 PM"
            currentCell = cell
        } else if(indexPath.row==1){
            // Create second cell
            let cell = tableView.dequeueReusableCellWithIdentifier("IncomingMessage", forIndexPath: indexPath) as! IncomingMessageCellController
            cell.message.text = "Hey, how's it going?"
            currentCell = cell
            
        } else if(indexPath.row==2){
            // Create second cell
            let cell = tableView.dequeueReusableCellWithIdentifier("TimeMessage", forIndexPath: indexPath) as! TimeMessageCellController
            cell.timeLabel.text = "TODAY 12:38 PM"
            currentCell = cell
        }else if(indexPath.row==6){
            // Create second cell
            let cell = tableView.dequeueReusableCellWithIdentifier("TimeMessage", forIndexPath: indexPath) as! TimeMessageCellController
            cell.timeLabel.text = "3:30 PM"
            currentCell = cell
        }else if(indexPath.row==7){
            // Create second cell
            let cell = tableView.dequeueReusableCellWithIdentifier("IncomingMessage", forIndexPath: indexPath) as! IncomingMessageCellController
            cell.message.text = "Sounds good, I'll see you later then."
            currentCell = cell
        } else{
            // Create all others
            let cell = tableView.dequeueReusableCellWithIdentifier("OutgoingMessage", forIndexPath: indexPath) as! OutgoingMessageCellController
            cell.message.text = "This is just sample text used as a filler to show what the message box looks like."
            currentCell = cell
        }
        // Configure the cell...
        return currentCell
    }
}
