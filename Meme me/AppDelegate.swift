//
//  AppDelegate.swift
//  Meme me
//
//  Created by Rohan Sarith Pethiyagoda on 2/08/2015.
//  Copyright (c) 2015 RP3. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    //initialize a shared data source with some default memes
    let darkSide = UIImage(named: "darkSide") //default meme 1
    var memes = [Meme]()
    let m = Meme(top: "Come to the dark side...",
                bottom: "...we have cookies",
                originalImage: UIImage(named: "darkSide")!,
                memedImage: UIImage(named: "darkSide")!)
    
    let yooda = Meme(top: "To use this app...",
        bottom: "...tap + you must",
        originalImage: UIImage(named: "yoda")!,
        memedImage: UIImage(named: "yoda")!)


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        memes.append(m)
        memes.append(yooda)
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

