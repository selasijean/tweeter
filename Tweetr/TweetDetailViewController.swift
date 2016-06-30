//
//  TweetDetailViewController.swift
//  Tweetr
//
//  Created by Jean Adedze on 6/28/16.
//  Copyright © 2016 Jean Adedze. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    
//    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    
    var tweet: Tweet?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetLabel.text = tweet?.text as? String
        let profileUrl = tweet!.user?.profileUrl_http
        if let profileUrl = profileUrl{
            avatarView.setImageWithURL(profileUrl)
        }
        nameLabel.text = tweet!.user?.name as? String
        handleLabel.text = "@" + (tweet!.user?.screenname as? String)!
        likeButton.selected = tweet!.likeStatus!
        retweetButton.selected = tweet!.retweetStatus!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressRetweetButton(sender: AnyObject) {
        if !retweetButton.selected{
            TwitterClient.sharedInstance.retweet(tweet!)
            retweetButton.selected = true
        }else{
            TwitterClient.sharedInstance.unretweet(tweet!)
            retweetButton.selected = false
    }
    }
    
    @IBAction func didPressLikeButton(sender: AnyObject) {
        
        if !likeButton.selected{
            TwitterClient.sharedInstance.favorite(tweet!)
            likeButton.selected = true
        }else{
            TwitterClient.sharedInstance.unfavorite(tweet!)
            likeButton.selected = false
        }
    }

    /**

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
 
 **/

}
