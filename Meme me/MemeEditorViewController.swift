//
//  MemeEditorViewController.swift
//  Meme me
//
//  Created by Rohan Sarith Pethiyagoda on 2/08/2015.
//  Copyright (c) 2015 RP3. All rights reserved.
//

import Foundation
import UIKit

class MemeEditorViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate,UIImagePickerControllerDelegate {
    
    //outlets
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var navbar: UINavigationBar!

    
    /*VIEW LIFECYCLE SETUP AND TEAR DOWN*/
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        subscribeToKeyboardNotifications()
        
        //selectively show camera button
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        shareButton.enabled = imagePickerView.image == nil ? false : true
        
        //format text
        let memeTextAttributes = [
            NSStrokeColorAttributeName: UIColor.blackColor(),
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 35)!,
            NSStrokeWidthAttributeName: -3.0
        ]
        
        //TODO: Increase height of text boxes
        topText.delegate = self
        topText.defaultTextAttributes = memeTextAttributes
        topText.textAlignment = NSTextAlignment.Center
        bottomText.delegate = self
        bottomText.defaultTextAttributes = memeTextAttributes
        bottomText.textAlignment = NSTextAlignment.Center
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func cancelEditing(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*EDITING LABEL TEXTS*/
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.text = textField.text == "" ? "TOP" : textField.text
        return true
    }
    
    /*HANDING KEYBOARD NOTIFICATIONS*/
    //necessary to know when the keyboard shows up, used in viewWillAppear
    func subscribeToKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if bottomText.isFirstResponder() {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification){
        if bottomText.isFirstResponder() {
            view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    
    /*PICKING AN EXISTING IMAGE*/
    @IBAction func pickAnImage(sender: AnyObject) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary //for existing images
        presentViewController(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            imagePickerView.contentMode = UIViewContentMode.ScaleAspectFill
            imagePickerView.image = image
        }
        //TODO: set contentMode (See UIView Content Modes) to force retain original aspect ratio
        //or have labels shift to always sit within image
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*TAKING A NEW IMAGE*/
    @IBAction func takeAnImage(sender: AnyObject) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.Camera //for new images
        presentViewController(pickerController, animated: true, completion: nil)
    }
    
    /*GENERATE AND SAVE NEW MEME FROM IMAGE AND TEXT*/
    func generateMeme() -> Meme{
        //Hide toolbar and navbar
        navbar.hidden = true
        toolbar.hidden = true;
        
        //capture screenshot
        UIGraphicsBeginImageContext(imagePickerView.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //show toolbar and navbar
        toolbar.hidden = false
        navbar.hidden = false
        
        //create a meme, save it, and return it
        let myMeme = Meme(top: topText.text!, bottom: bottomText.text!, originalImage: imagePickerView.image!, memedImage: memedImage)
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(myMeme)

        return myMeme
    }
    
    /*SHARE MEME*/
    @IBAction func shareMeme(sender: AnyObject) {
        let myMeme:Meme = generateMeme()
        var avc = UIActivityViewController(activityItems: [myMeme.memedImage], applicationActivities: nil)
        presentViewController(avc, animated: true, completion: nil)
    }
    
}