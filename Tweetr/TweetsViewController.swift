//
//  TweetsViewController.swift
//  Tweetr
//
//  Created by Jean Adedze on 6/28/16.
//  Copyright © 2016 Jean Adedze. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tweets: [Tweet]!
    var otherUser: User?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        pullHomeTimeLineData()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl){
        pullHomeTimeLineData()
        refreshControl.endRefreshing()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil{
            //return 20
            
            return tweets.count
        }else{
            return 0
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("tweetCell") as! TweetCell
        cell.tweet = tweets[indexPath.row]
        
        cell.profileView?.userInteractionEnabled = true
        cell.profileView?.tag = indexPath.row
        
        var tapped:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "TappedOnImage:")
        tapped.numberOfTapsRequired = 1
        cell.profileView.addGestureRecognizer(tapped)
        
        return cell
    }
    
    func TappedOnImage(sender:UITapGestureRecognizer){
        
        let gestureRec = sender as! UIGestureRecognizer
//        let userDetailViewController = segue.destinationViewController as! OtherUserProfileViewController
        let parent = gestureRec.view as! UIImageView
        let index = parent.tag
        let tweet = tweets[index]
        let userID = tweet.user!.userID
        TwitterClient.sharedInstance.showUserInfo(userID!, success: { (user: User) in
            print(user)
            print(user.name)
            self.otherUser = user
            self.performSegueWithIdentifier("otherUserSegue", sender: sender)
            //userDetailViewController.otherUser = user
            }, failure: { (error: NSError) in
                print(error)
        })
        
        
        
        //print(sender.view?.tag)
    }
    
    func pullHomeTimeLineData(){
        TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) in
            self.tweets = tweets
            //print(self.tweets.count)
            self.tableView.reloadData()
        }) { (error: NSError) in
                print(error.localizedDescription)
        }
    }

    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
       
        
    }
    
    
//    @IBAction func didTapOnProfilePhoto(sender: AnyObject) {
//        print("tapped")
//    performSegueWithIdentifier("otherProfileSegue", sender: sender)
//    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "detailSegue"{
            let cell = sender as! TweetCell
            let detailViewController = segue.destinationViewController as! TweetDetailViewController
            detailViewController.tweet = cell.tweet
  
        }else if segue.identifier == "otherUserSegue" {
            
//            let gestureRec = sender as! UIGestureRecognizer
            let userDetailViewController = segue.destinationViewController as! OtherUserProfileViewController
//            let parent = gestureRec.view as! UIImageView
//            let index = parent.tag
//            let tweet = tweets[index]
//            let userID = tweet.user!.userID
//            TwitterClient.sharedInstance.showUserInfo(userID!, success: { (user: User) in
//                print(user)
//                print(user.name)
                userDetailViewController.otherUser = otherUser
//                }, failure: { (error: NSError) in
//                    print(error)
//            })
            
        }
        
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
