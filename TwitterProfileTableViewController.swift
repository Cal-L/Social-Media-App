//
//  TwitterProfileTableViewController.swift
//  comblie
//
//  Created by Cal on 10/22/15.
//  Copyright © 2015 Comblie. All rights reserved.
//

import UIKit

class TwitterProfileTableViewController: UITableViewController {
    
    var currentCell : UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 44.0; // set to whatever your "average"
        self.tableView.registerNib(UINib(nibName: "TwitterPhotoCell", bundle: nil), forCellReuseIdentifier: "TwitterPhoto")
        self.tableView.registerNib(UINib(nibName: "TwitterTweetCell", bundle: nil), forCellReuseIdentifier: "TwitterTweet")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, var willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        //print(cells.val)
        //print(cells.parent)
        //print(cells.row)
        print(cell.frame.height)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
             let cell = tableView.dequeueReusableCellWithIdentifier("TwitterHeader", forIndexPath: indexPath)
            currentCell = cell
        }else if (indexPath.row == 1){
             let cell = tableView.dequeueReusableCellWithIdentifier("TwitterPhoto", forIndexPath: indexPath)
            currentCell = cell
        } else {
             let cell = tableView.dequeueReusableCellWithIdentifier("TwitterTweet", forIndexPath: indexPath) as! TwitterTweetCellController
            /*cell.retweetTextHeight.constant = CGFloat(0)
            cell.val = 2
            cell.row = indexPath*/
            cell.parent = self
            currentCell = cell
        }
        // Configure the cell...
        
        
        return currentCell
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
