//
//  ComposeViewController.swift
//  Tweetr
//
//  Created by Jean Adedze on 6/29/16.
//  Copyright © 2016 Jean Adedze. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var composeTweetField: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        composeTweetField.text = "What's happening?"
        composeTweetField.textColor = UIColor.lightGrayColor()
        composeTweetField.delegate = self
        
        //
        composeTweetField.becomeFirstResponder()
        composeTweetField.selectedTextRange = composeTweetField.textRangeFromPosition(composeTweetField.beginningOfDocument, toPosition: composeTweetField.beginningOfDocument)
        

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func didPressCloseButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
//    func textViewDidBeginEditing(textView: UITextView) {
//        if textView.textColor == UIColor.lightGrayColor() {
//            textView.text = nil
//            textView.textColor = UIColor.blackColor()
//        }
//
//    }
//    
//    
//    func textViewDidEndEditing(textView: UITextView) {
//        if textView.text!.isEmpty {
//            textView.text = "Placeholder"
//            textView.textColor = UIColor.lightGrayColor()
//        }
//
//    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:NSString = textView.text
        let updatedText = currentText.stringByReplacingCharactersInRange(range, withString:text)
        
        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {
            
            textView.text = "What's happening?"
            textView.textColor = UIColor.lightGrayColor()
            
            textView.selectedTextRange = textView.textRangeFromPosition(textView.beginningOfDocument, toPosition: textView.beginningOfDocument)
            
            return false
        }
            // Else if the text view's placeholder is showing and the
            // length of the replacement string is greater than 0, clear
            // the text view and set its color to black to prepare for
            // the user's entry
        else if textView.textColor == UIColor.lightGrayColor() && !text.isEmpty {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
        
        return true
    }
    
    func textViewDidChangeSelection(textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGrayColor() {
                textView.selectedTextRange = textView.textRangeFromPosition(textView.beginningOfDocument, toPosition: textView.beginningOfDocument)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func sendTweetButton(sender: AnyObject) {
        let tweet = composeTweetField.text
        TwitterClient.sharedInstance.sendTweet(tweet)
        dismissViewControllerAnimated(true, completion: nil)
    }

}
