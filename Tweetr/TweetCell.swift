//
//  TweetCell.swift
//  Tweetr
//
//  Created by Jean Adedze on 6/28/16.
//  Copyright © 2016 Jean Adedze. All rights reserved.
//

import UIKit
import NSDate_TimeAgo

class TweetCell: UITableViewCell {
    
    
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userhandleLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var numberOfRetweets: UILabel!
    @IBOutlet weak var numberOfLikes: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    
    var tweet: Tweet! {
        didSet{
            tweetLabel.text = tweet.text as? String
            let profileUrl = tweet.user?.profileUrl_http
            if let profileUrl = profileUrl{
               profileView.setImageWithURL(profileUrl)
            }
            nameLabel.text = tweet.user?.name as? String
            userhandleLabel.text = "@" + (tweet.user?.screenname as? String)!
            retweetButton.selected = tweet.retweetStatus!
            likeButton.selected = tweet.likeStatus!
            let date = tweet.timeStamp!
            let ago = date.timeAgo()
            timeStampLabel.text = ago
            numberOfLikes.text = String(tweet.favoritesCount)
            numberOfRetweets.text = String(tweet.retweetCount)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func didPressRetweetButton(sender: AnyObject) {
        if !retweetButton.selected{
            TwitterClient.sharedInstance.retweet(tweet)
            retweetButton.selected = true
            tweet.retweetStatus = true
            tweet.retweetCount += 1
            numberOfRetweets.text = String(tweet.retweetCount)
        }else{
            TwitterClient.sharedInstance.unretweet(tweet)
            retweetButton.selected = false
            tweet.retweetStatus = false
            tweet.retweetCount -= 1
            numberOfRetweets.text = String(tweet.retweetCount)
        }
        
    }
    
    
    @IBAction func didPressLikeButton(sender: AnyObject) {
        if !likeButton.selected{
            TwitterClient.sharedInstance.favorite(tweet)
            likeButton.selected = true
            tweet.likeStatus = true
            tweet.favoritesCount += 1
            numberOfLikes.text = String(tweet.favoritesCount)
        }else{
            TwitterClient.sharedInstance.unfavorite(tweet)
            likeButton.selected = false
            tweet.likeStatus = false
            tweet.favoritesCount -= 1
            numberOfLikes.text = String(tweet.favoritesCount)

        }
        
        
    }
    
    
    
    

}
