//
//  TwitterClient.swift
//  Tweetr
//
//  Created by Jean Adedze on 6/27/16.
//  Copyright © 2016 Jean Adedze. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "T13DsIJhg09gBPaWVwsFKXk7s", consumerSecret: "JrBdYyRsXl6Jd1LsJgpQegvAIcGMsmxPPlBmOFkRZLefujwKUL")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    
    func login(success: () -> () ,failure: (NSError) -> ()){
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token" , method: "GET", callbackURL: NSURL(string: "twitterdemo://oauth"), scope: nil, success: { (requestToken:BDBOAuth1Credential!) in
            print("I got my token")
            let url  = NSURL(string:"https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
            
        }) { (error: NSError!) in
            print("error: \(error.localizedDescription)")
            self.loginFailure?(error)
        }
    }
    
    func logout(){
        User.currentUser = nil
        deauthorize()
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
        
    }
    
    func handleOpenUrl(url: NSURL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessTokenWithPath("oauth/access_token" , method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("I got access token")
            self.currentAccount({ (user: User) in
                User.currentUser = user
                self.loginSuccess?()
                }, failure: { (error: NSError) in
                    self.loginFailure?(error)
            })
            
            
        }) { (error: NSError!) in
            print("error: \(error.localizedDescription)")
            self.loginFailure?(error)
        }
    }

    func homeTimeline(success: ([Tweet]) -> (), failure: (NSError) -> () ){
        
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) in
            
            let dictionaries  = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries)
            success(tweets)
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) in
               failure(error)
        })
        
    }
    
    func currentAccount(success: (User) -> (), failure: (NSError) -> ()){
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) in
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            success(user)

            }, failure: { (task: NSURLSessionDataTask?, error: NSError) in
                failure(error)
        })

    }
    
    func retweet(tweet: Tweet){
        let tweetID = tweet.tweetID
        let urlString = "1.1/statuses/retweet/\(tweetID).json"
        POST(urlString, parameters: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) in
            //print(response)
        }) { (task: NSURLSessionDataTask?, error: NSError) in
                print(error)
        }
    }
    
    func unretweet(tweet:Tweet){
        let tweetID = tweet.tweetID
        //print(retweetID)
        let urlString = "1.1/statuses/unretweet/\(tweetID).json"
        POST(urlString, parameters: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) in
            //print(response)
        }) { (task: NSURLSessionDataTask?, error: NSError) in
            print(error)
        }
    }
    
    func favorite(tweet: Tweet){
        let tweetID = tweet.tweetID
        let urlString = "1.1/favorites/create.json?id=\(tweetID)"
        POST(urlString, parameters: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) in
        }) { (task: NSURLSessionDataTask?, error: NSError) in
            
        }
    }
    
    func unfavorite(tweet: Tweet){
        let tweetID = tweet.tweetID
        let urlString = "1.1/favorites/destroy.json?id=\(tweetID)"
        POST(urlString, parameters: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) in
        }) { (task: NSURLSessionDataTask?, error: NSError) in
            
        }
    }
    
    func sendTweet(tweet: String){
        let urlString = "1.1/statuses/update.json"
        let params = ["status" : tweet]
        
        POST(urlString, parameters: params, success: { (task: NSURLSessionDataTask, response: AnyObject?) in
            //print(response)
        }) { (task: NSURLSessionDataTask?, error: NSError) in
            //print(error)
            
        }
    }
    
    func showUserInfo(userID: String, success: (User) ->(), failure: (NSError) ->()){
        
        let urlString = "1.1/users/show.json?user_id=\(userID)"
        GET(urlString, parameters: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) in
            let userDictionary = response as? NSDictionary
            let user = User(dictionary: userDictionary!)
            success(user)
        }) { (task: NSURLSessionDataTask?, error: NSError) in
                failure(error)
        }
        
    }

}
