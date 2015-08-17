//
//  MemeCollectionViewController.swift
//  Meme me
//
//  Created by Rohan Sarith Pethiyagoda on 2/08/2015.
//  Copyright (c) 2015 RP3. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewController: UICollectionViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionCell", forIndexPath: indexPath) as! CustomCell
        let source = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        let meme = source[indexPath.row]
        
        // Set the image
        cell.meme.image = meme.memedImage
        cell.meme.contentMode = UIViewContentMode.ScaleToFill
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath){
        
        let vc = storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        vc.meme = (UIApplication.sharedApplication().delegate as! AppDelegate).memes[indexPath.row]
        navigationController!.pushViewController(vc, animated: true)
        
    }
    
}
