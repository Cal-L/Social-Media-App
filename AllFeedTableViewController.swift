//
//  AllFeedTableViewController.swift
//  comblie
//
//  Created by Cal on 10/24/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class AllFeedTableViewController: UITableViewController {
    
    var dataSource : AllFeedDatasource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = AllFeedDatasource(tableView: self.tableView, parent: self)
        self.tableView.dataSource = dataSource
        
        self.edgesForExtendedLayout = UIRectEdge.None
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 44.0; // set to whatever your "average"
        self.tableView.allowsSelection = false
        
        self.tableView.registerNib(UINib(nibName: "VineFeedCell", bundle: nil), forCellReuseIdentifier: "VineFeed")
        self.tableView.registerNib(UINib(nibName: "TwitterTweetCell", bundle: nil), forCellReuseIdentifier: "TwitterTweet")
        self.tableView.registerNib(UINib(nibName: "TumblrPhotoCell", bundle: nil), forCellReuseIdentifier: "TumblrPhoto")
        self.tableView.registerNib(UINib(nibName: "InstagramFeedCell", bundle: nil), forCellReuseIdentifier: "InstagramFeed")

    }

   
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
