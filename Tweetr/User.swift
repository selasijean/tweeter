//
//  User.swift
//  Tweetr
//
//  Created by Jean Adedze on 6/27/16.
//  Copyright © 2016 Jean Adedze. All rights reserved.
//

import UIKit

class User: NSObject {
    
    static let userDidLogoutNotification = "UserDidLogout"
    
    var name: NSString?
    var screenname: NSString?
    var profileUrl_https: NSURL?
    var tagline: NSString?
    var profileUrl_http: NSURL?
    var userID: String?
    var tweetsCount: Int?
    var followersCount: Int?
    var followingCount: Int?
    var profileBanner: NSURL?
    
    
    //
    var dictionary: NSDictionary?
    //
    
    init(dictionary: NSDictionary){
        
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        
        //initializing profileUrl_https property
        let profileUrlString_https = dictionary["profile_image_url_https"] as? String
        if let profileUrlString_https = profileUrlString_https{
            profileUrl_https = NSURL(string: profileUrlString_https)
        }
        
        //initializing profileUrl_http property
        let profileUrlString_http = dictionary["profile_image_url"] as? String
        if let profileUrlString_http = profileUrlString_http{
            profileUrl_http = NSURL(string: profileUrlString_http)
        }
        
        
        tagline = dictionary["description"] as? String
        userID = dictionary["id_str"] as? String
        tweetsCount = dictionary["statuses_count"] as? Int
        followersCount = dictionary["followers_count"] as? Int
        followingCount = dictionary["friends_count"] as? Int
        let bannerUrlString = dictionary["profile_banner_url"] as? String
        if let bannerUrlString = bannerUrlString{
            profileBanner = NSURL(string: bannerUrlString)
        }

    }
    static var _currentUser: User?
    
    
    class var currentUser: User?{
        get{
            if _currentUser == nil{
                let defaults = NSUserDefaults.standardUserDefaults()
                let userData = defaults.objectForKey("currentUserData") as? NSData
                
                if let userData = userData{
                    let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            
            return _currentUser
        }
        set(user){
            _currentUser = user
            
            let defaults = NSUserDefaults.standardUserDefaults()
            
            if let user = user{
               let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
                defaults.setObject(data, forKey: "currentUserData")
            }else{
                defaults.setObject(nil, forKey: "currentUserData")
            }
            defaults.synchronize()
            
            
        }
    }

}
