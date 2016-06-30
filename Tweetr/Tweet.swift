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
    
    
    
    init(dictionary: NSDictionary){
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        let userDictionary = dictionary["user"] as! NSDictionary
        user = User(dictionary: userDictionary)
        
        let timeStampString = dictionary["created_at"] as? String
        
        if let timeStampString = timeStampString{
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timeStamp = formatter.dateFromString(timeStampString)
        }
        
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
