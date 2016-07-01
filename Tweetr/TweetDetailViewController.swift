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
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    
    
    var tweet: Tweet?

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.hidden = true
        
        tweetLabel.text = tweet?.text as? String
        let profileUrl = tweet!.user?.profileUrl_http
        if let profileUrl = profileUrl{
            avatarView.setImageWithURL(profileUrl)
        }
        nameLabel.text = tweet!.user?.name as? String
        handleLabel.text = "@" + (tweet!.user?.screenname as? String)!
        likeButton.selected = tweet!.likeStatus!
        retweetButton.selected = tweet!.retweetStatus!
        let date = tweet!.timeStamp!
        //let ago = date.timeAgo()
        timeStampLabel.text = date.description
        if (tweet!.favoritesCount > 0) || (tweet?.retweetCount > 0){
            contentView.hidden = false
            retweetCountLabel.text = String(tweet!.retweetCount)
            likesCountLabel.text = String(tweet!.favoritesCount)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressRetweetButton(sender: AnyObject) {
        if !retweetButton.selected{
            TwitterClient.sharedInstance.retweet(tweet!)
            retweetButton.selected = true
            retweetCountLabel.text = String(Int(retweetCountLabel.text!)! + 1)
        }else{
            TwitterClient.sharedInstance.unretweet(tweet!)
            retweetButton.selected = false
            retweetCountLabel.text = String(Int(retweetCountLabel.text!)! - 1)
    }
    }
    
    @IBAction func didPressLikeButton(sender: AnyObject) {
        
        if !likeButton.selected{
            TwitterClient.sharedInstance.favorite(tweet!)
            likeButton.selected = true
            likesCountLabel.text = String(Int(likesCountLabel.text!)! + 1)
        }else{
            TwitterClient.sharedInstance.unfavorite(tweet!)
            likeButton.selected = false
            likesCountLabel.text = String(Int(likesCountLabel.text!)! - 1)
        }
    }

    /**

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
 
 **/

}
