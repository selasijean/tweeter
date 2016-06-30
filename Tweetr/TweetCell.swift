//
//  TweetCell.swift
//  Tweetr
//
//  Created by Jean Adedze on 6/28/16.
//  Copyright © 2016 Jean Adedze. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userhandleLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
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
        }else{
            TwitterClient.sharedInstance.unretweet(tweet)
            retweetButton.selected = false
        }
        
    }
    
    
    @IBAction func didPressLikeButton(sender: AnyObject) {
        if !likeButton.selected{
            TwitterClient.sharedInstance.favorite(tweet)
            likeButton.selected = true
        }else{
            TwitterClient.sharedInstance.unfavorite(tweet)
            likeButton.selected = false
        }
        
        
    }
    
    
    
    

}
