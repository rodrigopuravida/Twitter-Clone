//
//  TweetDetailViewController.swift
//  Twiter Clone
//
//  Created by Rodrigo Carballo on 1/7/15.
//  Copyright (c) 2015 Rodrigo Carballo. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
  
  // TODO: remove screenName variable and label
  
  var tweet : Tweet!
  var networkController : NetworkController!

  //@IBOutlet weak var detailTweetImage: UIImageView!
  @IBOutlet weak var userTweeterLabel: UILabel!
  @IBOutlet weak var detailedTweetText: UILabel!
  
  @IBOutlet weak var favoritesCount: UILabel!
  @IBOutlet weak var btnUserTimeline: UIButton!
  @IBAction func showUserTimeLine(sender: AnyObject) {
    
    //instantiate view controller
    let tweetVC = self.storyboard?.instantiateViewControllerWithIdentifier("USER_TIMELINE") as UserTimelineViewController
    tweetVC.networkController = self.networkController
    //tweetVC.tweet = self.tweets[indexPath.row]
    self.navigationController?.pushViewController(tweetVC, animated: true)
    
    
    
        
  }
    override func viewDidLoad() {
        super.viewDidLoad()
      
      self.userTweeterLabel.text = tweet.username
      self.btnUserTimeline.setBackgroundImage(tweet.image, forState: UIControlState.Normal)

      
      self.networkController.fetchDetailsOnTweet(tweet.userId, completionHandler: { (infoDictionary, errorDescription) -> () in
        
        if errorDescription == nil {
          self.tweet.updateWithInfo(infoDictionary!)
          self.detailedTweetText.text = self.tweet.detailedTweetText
          self.favoritesCount.text = self.tweet.favoriteCount
        }
  })

            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
