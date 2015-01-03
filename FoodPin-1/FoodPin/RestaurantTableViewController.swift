//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Simon Ng on 11/8/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    var restaurantNames = ["すっぴんメイク","ひげ男メイク","メガネメイク"]
    
    var restaurantImages = ["manome.png","reon.png","nakahara.png"]

    var restaurantLocations = ["manome","reon","nakahara"]
    
    var restaurantTypes = ["2015/2/10", "2014/11/3", "2013/3/4"]

    var restaurantIsVisited = [Bool](count: 21, repeatedValue: false)

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return self.restaurantNames.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as CustomTableViewCell
        
        // Configure the cell...
        cell.nameLabel.text = restaurantNames[indexPath.row]
        cell.thumbnailImageView.image = UIImage(named: restaurantImages[indexPath.row])
        cell.locationLabel.text = restaurantLocations[indexPath.row]
        cell.typeLabel.text = restaurantTypes[indexPath.row]
//        cell.accessoryType = restaurantIsVisited[indexPath.row] ? .Checkmark : .None
        cell.favorIconImageView.hidden = !restaurantIsVisited[indexPath.row]

        // Circular image
        cell.thumbnailImageView.layer.cornerRadius = cell.thumbnailImageView.frame.size.width / 2
        cell.thumbnailImageView.clipsToBounds = true
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // Create an option menu as an action sheet
        let optionMenu = UIAlertController(title: nil, message: "Menu", preferredStyle: .ActionSheet)
        
        // Add Cancel action to the menu
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        
        // Add Call action to the menu
        let callActionHandler = { (action:UIAlertAction!) -> Void in
            
            let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. Please retry later.", preferredStyle: .Alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alertMessage, animated: true, completion: nil)
            
        }
        /*
        let callAction = UIAlertAction(title: "Call " + "123-000-\(indexPath.row)", style: UIAlertActionStyle.Default, handler: callActionHandler)
        optionMenu.addAction(callAction)
        */
        
        let callAction = UIAlertAction(title: "Put into FavList", style: UIAlertActionStyle.Default, handler: callActionHandler)
        optionMenu.addAction(callAction)
        
        
        
        // Add I've been here action to the menu
        let isVisitedTitle = "Listen" //restaurantIsVisited[indexPath.row] ? "I haven't been to here before" : "I've been here"
        let isVisitedAction = UIAlertAction(title: isVisitedTitle, style: .Default, handler: {
            (action:UIAlertAction!) -> Void in
            
            let cell = tableView.cellForRowAtIndexPath(indexPath) as CustomTableViewCell
            
            // Toggle checkmark
            self.restaurantIsVisited[indexPath.row] = self.restaurantIsVisited[indexPath.row] ? false : true
//            cell.accessoryType = self.restaurantIsVisited[indexPath.row] ? .Checkmark : .None
            cell.favorIconImageView.hidden = !self.restaurantIsVisited[indexPath.row]
        })
        optionMenu.addAction(isVisitedAction)

        // Display the menu
        self.presentViewController(optionMenu, animated: true, completion: nil)
        
        // Deselect the cell
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            self.restaurantNames.removeAtIndex(indexPath.row)
            self.restaurantLocations.removeAtIndex(indexPath.row)
            self.restaurantTypes.removeAtIndex(indexPath.row)
            self.restaurantIsVisited.removeAtIndex(indexPath.row)
            self.restaurantImages.removeAtIndex(indexPath.row)

            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject] {
        
        var shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Share", handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
                let postString = self.restaurantNames[indexPath.row] + "をシェアしました!!"
                let activityViewController = UIActivityViewController(activityItems: [postString], applicationActivities: nil)
                self.presentViewController(activityViewController, animated: true, completion: nil)
            }
        )
        
        var deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete",handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in

            // Delete the row from the data source
            self.restaurantNames.removeAtIndex(indexPath.row)
            self.restaurantLocations.removeAtIndex(indexPath.row)
            self.restaurantTypes.removeAtIndex(indexPath.row)
            self.restaurantIsVisited.removeAtIndex(indexPath.row)
            self.restaurantImages.removeAtIndex(indexPath.row)

            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)

            }
        )
        
        shareAction.backgroundColor = UIColor(red: 255.0/255.0, green: 166.0/255.0, blue: 51.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)

        return [deleteAction, shareAction]
    }
}
