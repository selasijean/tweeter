//
//  ReplyViewController.swift
//  Tweetr
//
//  Created by Jean Adedze on 6/30/16.
//  Copyright © 2016 Jean Adedze. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController {

    @IBOutlet weak var replyTextView: UITextView!
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mentions = tweet.mentions
        var mentionsString = ""
        if !mentions.isEmpty{
            for mention in mentions{
                if mention != tweet.user?.screenname{
                    mentionsString.appendContentsOf(" @" + mention)
                }
            }
        }
        print(mentionsString)
        replyTextView.text = "@" + (tweet.user?.screenname as! String) + mentionsString
        replyTextView.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func sendTweetButton(sender: AnyObject) {
        
        let statusID = Int((tweet.tweetID as? String)!)
        let reply = replyTextView.text
        TwitterClient.sharedInstance.sendReply(reply, tweetID: statusID!) { 
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func didTapOnCloseButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
