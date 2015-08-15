//
//  MemeTableViewController.swift
//  Meme me
//
//  Created by Rohan Sarith Pethiyagoda on 2/08/2015.
//  Copyright (c) 2015 RP3. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()

    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("memeCell") as! CustomRow
        let source = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        let meme = source[indexPath.row]
        
        // Set the name and image
        cell.memeImage.image = meme.memedImage
        cell.memeText.text = meme.top
        
        // If the cell has a detail label, we will put the evil scheme in.
        if let detailTextLabel = cell.detailTextLabel {
            detailTextLabel.text = meme.top + ", " + meme.bottom
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        vc.meme = (UIApplication.sharedApplication().delegate as! AppDelegate).memes[indexPath.row]
        self.navigationController!.pushViewController(vc, animated: true)
        
    }
    
}
