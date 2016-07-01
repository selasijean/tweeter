//
//  Tweet.swift
//  Tweetr
//
//  Created by Jean Adedze on 6/27/16.
//  Copyright © 2016 Jean Adedze. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text: NSString?
    var timeStamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var user: User?
    var tweetID: NSString!
    var retweetStatus: Bool!
    var likeStatus: Bool!
    var mentions:[String] = []
    
    
    init(dictionary: NSDictionary){
        //print(dictionary)
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        //print(favoritesCount)
        
        let userDictionary = dictionary["user"] as! NSDictionary
        user = User(dictionary: userDictionary)
        
        let timeStampString = dictionary["created_at"] as? String
        
        if let timeStampString = timeStampString{
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timeStamp = formatter.dateFromString(timeStampString)
        }
        let entitites = dictionary["entities"] as? NSDictionary
        let user_mentions = entitites!["user_mentions"] as? [NSDictionary]
        //print(user_mentions)
        if let user_mentions = user_mentions{
            for mention in user_mentions{
                let screen_name = mention["screen_name"] as! String
                mentions.append(screen_name)
                //print(mentions)
                //print(screen_name)
            }
        }
        
        //print(timeStamp)
        tweetID = dictionary["id_str"] as? String
        retweetStatus = dictionary["retweeted"] as? Bool
        likeStatus = dictionary["favorited"] as? Bool
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries{
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
       return tweets
    }

}
