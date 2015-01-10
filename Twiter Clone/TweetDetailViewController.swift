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
    
    println("Clicked the button")
    
    //instantiate view controller
    let userVC = self.storyboard?.instantiateViewControllerWithIdentifier("USER_TIMELINE") as UserTimelineViewController
    userVC.networkController = self.networkController
    userVC.userTimeLineId = self.tweet.userTimeLineID
    userVC.userTimeLineName = self.tweet.userTimeLineName
    userVC.userTimeLineImage = self.tweet.userTimeLineImage
    userVC.userTimeLineLocation = self.tweet.userTimeLineLocation
    
    
    
    self.navigationController?.pushViewController(userVC, animated: true)
        
  }
    override func viewDidLoad() {
        super.viewDidLoad()
      
      self.userTweeterLabel.text = tweet.username
      
      //TODO: change button method
      self.btnUserTimeline.setBackgroundImage(tweet.image, forState: UIControlState.Normal)
      
      self.networkController.fetchDetailsOnTweet(tweet.userId, completionHandler: { (infoDictionary, errorDescription) -> () in
        
        if errorDescription == nil {
          self.tweet.updateWithInfo(infoDictionary!)
          self.detailedTweetText.text = self.tweet.detailedTweetText
          
          //handling whether count is one for proper display
          
          if (self.tweet.favoriteCount?.toInt() == 1) {
            self.favoritesCount.text = self.tweet.favoriteCount! + " Favorite"
            
          }
          else {
            self.favoritesCount.text = self.tweet.favoriteCount! + " Favorites"
            
          }

        }
        
  })

            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
