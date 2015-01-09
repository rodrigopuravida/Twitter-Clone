//
//  ViewController.swift
//  Twiter Clone
//
//  Created by Rodrigo Carballo on 1/5/15.
//  Copyright (c) 2015 Rodrigo Carballo. All rights reserved.
//

import UIKit
import Accounts
import Social

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  // TODO: Look over Autolayout.  Still some To are chopped up
  // TODO: Add label for user

  
  var tweets = [Tweet]()
  let networkController = NetworkController()
  
  @IBOutlet weak var tweetTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    self.tweetTableView.dataSource = self
    self.tweetTableView.delegate = self
    
    
    //call the network controller method with closure
    self.networkController.fetchTwitterHomeTimeline { (tweets, errorString) -> () in
      if errorString == nil {
        self.tweets = tweets!
        self.tweetTableView.reloadData()
      } else {
        //show user alert view telling them it didnt work
      }
    }
 
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.tweets.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TWEET_CELL", forIndexPath: indexPath) as CustomTableViewCell
    
    //this var name is what gets the value of user name fromm within user dictionary which is inside json
    let name = self.tweets[indexPath.row].user["name"] as String
    
    let tweet = self.tweets[indexPath.row]
    
    //this after adding CustomTableViewCell.swift - Day1
    //concatenating tweet text + name
    
    cell.tweetCustomLabel.text = tweet.text + " by " + name
    
    //Lazy loading the images
    if tweet.image == nil {
      self.networkController.fetchImageForTweet(tweet, completionHandler: { (image) -> () in
        self.tweetTableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
      })
    } else {
      cell.customImage.image = tweet.image
    }
    return cell
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    let currentTweet = self.tweets[indexPath.row]
    
    let currentUserId = self.tweets[indexPath.row].userId
        
    //here is where I need to call my function with closure
    self.networkController.fetchDetailsOnTweet(currentUserId, completionHandler: { (SingeTweet, errorString) -> () in
      println("I'm back here")
    })

    //instantiate view controller
    let tweetVC = self.storyboard?.instantiateViewControllerWithIdentifier("TweetVC") as TweetDetailViewController
    tweetVC.networkController = self.networkController
    
    tweetVC.tweet = self.tweets[indexPath.row]
    self.navigationController?.pushViewController(tweetVC, animated: true)
  
  }
  
  

  
}


  

