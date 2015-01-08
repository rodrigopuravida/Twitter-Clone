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

  @IBOutlet weak var screenNameTweeter: UILabel!
  @IBOutlet weak var detailTweetImage: UIImageView!
  @IBOutlet weak var userTweeterLabel: UILabel!
  @IBOutlet weak var detailedTweetText: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      self.userTweeterLabel.text = tweet.username
      
      
      
      
      self.networkController.fetchDetailsOnTweet(tweet.userId, completionHandler: { (infoDictionary, errorDescription) -> () in
        
        if errorDescription == nil {
          self.tweet.updateWithInfo(infoDictionary!)
          self.detailedTweetText.text = self.tweet.detailedTweetText
          self.screenNameTweeter.text = self.tweet.screenName

        }
      })

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
