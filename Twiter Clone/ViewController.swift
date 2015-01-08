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
  
  var tweets = [Tweet]()
  let networkController = NetworkController()
  
  @IBOutlet weak var tweetTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    self.tweetTableView.dataSource = self
    
    
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
    
    println("userID " + tweet.userId)
    
    //setting image background to blue so we can see the image.  Will show only if no images is present
    cell.customImage.backgroundColor = UIColor.blueColor()
    
    
    //loading image from Tweet
    
    //variable referencing the image for each tweet
    let tweetImage = self.tweets[indexPath.row].user["profile_image_url"] as String
    
    let imageURL = NSURL(string: tweetImage)
    
    //adding images by converting NSURL to  data and then to to Image
    if let data = NSData(contentsOfURL: imageURL!){
      cell.customImage.contentMode = UIViewContentMode.ScaleAspectFit
      cell.customImage.image = UIImage(data: data)
    }
    
    return cell
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.tweetTableView.indexPathForSelectedRow()
    
  }
}


  

