//
//  MyProfileViewController.swift
//  Tweetr
//
//  Created by Jean Adedze on 6/29/16.
//  Copyright © 2016 Jean Adedze. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var profilePhotoImageView: UIImageView!
    
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    var myself = User._currentUser
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tweetCountLabel.text = String((myself?.tweetsCount)!)
        followersCountLabel.text = String((myself?.followersCount)!)
        followingCountLabel.text = String((myself?.followingCount)!)
        let profileBanner = myself?.profileBanner
        if let profileBanner = profileBanner{
            bannerImageView.setImageWithURL(profileBanner)
        }
        
        profilePhotoImageView.setImageWithURL((myself?.profileUrl_http)!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
