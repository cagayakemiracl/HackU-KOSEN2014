//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Simon Ng on 11/8/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

import UIKit
import QuartzCore
import Social



class TweetTableViewController: UITableViewController {
    

    
    var NameOfMake = ["すっぴんメイク","めがねメイク","ヒゲメイク"]
    
    var ImageOfMake = ["hige.png","manome.png","nakahara.png"]
    
    var AuthorOfMake = ["Manome","Nakahara","Reon"]
    
    var UpdateOfMake = ["2015/01/01","2015/01/02","2015/01/11"]
    
    func tweet(message: String? = nil, image: UIImage? = nil, url: NSURL? = nil) {
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
            let controller = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            controller.setInitialText(message)
            controller.addImage(image)
            controller.addURL(url)
            controller.completionHandler = { (result:SLComposeViewControllerResult) -> Void in
                switch result {
                case SLComposeViewControllerResult.Cancelled:
                    NSLog("result: cancelled")
                case SLComposeViewControllerResult.Done:
                    // TODO: ADD SOME CODE FOR SUCCESS
                    NSLog("result: done")
                }
            }
            
            self.presentViewController(controller, animated: true, completion: { () -> Void in
                // controller is presented... do something if needed
            })
        } else {
            NSLog("Twitter is not available")
        }
        
    }
    

    var restaurantIsVisited = [Bool](count: 21, repeatedValue: false)
    var makeIsVisited = [Bool](count: 3, repeatedValue: false)

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
        return self.NameOfMake.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as CustomTableViewCell
        
        // Configure the cell...
        cell.nameLabel.text = NameOfMake[indexPath.row]
        cell.makeImageView.image = UIImage(named: ImageOfMake[indexPath.row])
        cell.AuthorLabel.text = AuthorOfMake[indexPath.row]
        cell.UpdateLabel.text = UpdateOfMake[indexPath.row]

        // Circular image
        /*
        cell.makelImageView.layer.cornerRadius = cell.makeImageView.frame.size.width / 2
        cell.makeImageView.clipsToBounds = true
        */
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // Create an option menu as an action sheet
        let optionMenu = UIAlertController(title: nil, message: "Have you done to make?", preferredStyle: .ActionSheet)
        
        // Add Cancel action to the menu
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        
        // Add Call action to the menu
        let callActionHandler = { (action:UIAlertAction!) -> Void in
            
            let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sounds Good!", preferredStyle: .Alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alertMessage, animated: true, completion: nil)
            
        }
        
        let callAction = UIAlertAction(title: NameOfMake[indexPath.row], style: UIAlertActionStyle.Default, handler: callActionHandler)
        optionMenu.addAction(callAction)
        

        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            self.NameOfMake.removeAtIndex(indexPath.row)
            self.ImageOfMake.removeAtIndex(indexPath.row)
            self.AuthorOfMake.removeAtIndex(indexPath.row)
            self.UpdateOfMake.removeAtIndex(indexPath.row)

            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject] {
        
        var shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Share", handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in

            let shareMenu = UIAlertController(title: nil, message: "Share using", preferredStyle: .ActionSheet)
            let twitterAction = UIAlertAction(title: "Twitter", style: UIAlertActionStyle.Default, handler: {
                (action:UIAlertAction!) -> Void in
                    self.tweet(message: self.NameOfMake[indexPath.row]+"をShareしました。")
                })
            let facebookAction = UIAlertAction(title: "Facebook", style: UIAlertActionStyle.Default, handler: nil)
            let emailAction = UIAlertAction(title: "Email", style: UIAlertActionStyle.Default, handler: nil)
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
            
            shareMenu.addAction(twitterAction)
            shareMenu.addAction(facebookAction)
            shareMenu.addAction(emailAction)
            shareMenu.addAction(cancelAction)
            
            self.presentViewController(shareMenu, animated: true, completion: nil)
            }
        )
        
        var deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete",handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in

            // Delete the row from the data source
            self.NameOfMake.removeAtIndex(indexPath.row)
            self.ImageOfMake.removeAtIndex(indexPath.row)
            self.AuthorOfMake.removeAtIndex(indexPath.row)
            self.UpdateOfMake.removeAtIndex(indexPath.row)

            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)

            }
        )
        
        shareAction.backgroundColor = UIColor(red: 255.0/255.0, green: 166.0/255.0, blue: 51.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)

        return [deleteAction, shareAction]
    }
    


    

}
