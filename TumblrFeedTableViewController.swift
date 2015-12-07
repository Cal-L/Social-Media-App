//
//  TumblrFeedTableViewController.swift
//  comblie
//
//  Created by Cal on 10/24/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class TumblrFeedTableViewController: UITableViewController {
    
    var dataSource : TumblrFeedDatasource!
    var isProfile : Bool!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.restorationIdentifier?.rangeOfString("Feed") != nil) {
            self.isProfile = false
        } else {
            self.isProfile = true
        }
        
        // READ DATASOURCE HERE
        self.dataSource = TumblrFeedDatasource(tableView: self.tableView, isProfile: self.isProfile)
        self.tableView.dataSource = self.dataSource
        
        self.edgesForExtendedLayout = UIRectEdge.None
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 44.0; // set to whatever your "average"
        self.tableView.allowsSelection = false
        
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
