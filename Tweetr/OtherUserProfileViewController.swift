//
//  OtherUserProfileViewController.swift
//  Tweetr
//
//  Created by Jean Adedze on 6/29/16.
//  Copyright © 2016 Jean Adedze. All rights reserved.
//

import UIKit

class OtherUserProfileViewController: UIViewController {

    @IBOutlet weak var backgroundPhotoImageView: UIImageView!
    
    @IBOutlet weak var profilePhotoImageView: UIImageView!
    @IBOutlet weak var numberTweetsLabel: UILabel!
    @IBOutlet weak var numberFollowingLabel: UILabel!
    @IBOutlet weak var numberFollowersLabel: UILabel!
    
    var otherUser: User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let banner = otherUser?.profileBanner
        if let banner = banner{
            backgroundPhotoImageView.setImageWithURL((otherUser?.profileBanner)!)
        }
        profilePhotoImageView.setImageWithURL((otherUser?.profileUrl_http)!)
        numberTweetsLabel.text = String((otherUser?.tweetsCount)!)
        numberFollowersLabel.text = String((otherUser?.followersCount)!)
        numberFollowingLabel.text = String((otherUser?.followingCount)!)

        
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
