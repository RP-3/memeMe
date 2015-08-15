//
//  MemeDetailViewController.swift
//  Meme me
//
//  Created by Rohan Sarith Pethiyagoda on 13/08/2015.
//  Copyright (c) 2015 RP3. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController: UIViewController {
    
    var meme: Meme!
    @IBOutlet weak var memeDetailImage: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        memeDetailImage.image = meme.memedImage
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}