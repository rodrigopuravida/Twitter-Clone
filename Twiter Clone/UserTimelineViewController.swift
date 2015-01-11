//
//  UserTimelineViewController.swift
//  Twiter Clone
//
//  Created by Rodrigo Carballo on 1/8/15.
//  Copyright (c) 2015 Rodrigo Carballo. All rights reserved.
//

import UIKit

class UserTimelineViewController: UIViewController, UITableViewDataSource {
  
  //TODO: Validate for null conditions
  //TODO: Ger Profile banner
  
  var tweets : [Tweet]!
  var images : BackGroundImage!
  var userTimeLineId : String!
  var userTimeLineName : String!
  var userTimeLineImage : String!
  var userTimeLineLocation : String!
  var networkController : NetworkController!
  var sizes : [String : AnyObject]!
  var jsonDictionary : [String : AnyObject]!

  
  
  
  @IBOutlet weak var userTimeLineHeader: UIView!
  @IBOutlet weak var userTimeLineTableView: UITableView!
  @IBOutlet weak var lblUserTimeLine: UILabel!
  @IBOutlet weak var lblUserTimeLineName: UILabel!
  @IBOutlet weak var lblUserTimeLineLocation: UILabel!


  override func viewDidLoad() {
    super.viewDidLoad()

    
      self.networkController.fetchUserBackgroundImage(self.userTimeLineId, completionHandler: { (images, errorDescription) -> () in
      println("I made to the place I had called to get background image")
      
 
      self.images = BackGroundImage(images!)
      println("This is platform")
      println(self.images.platform)
    
      println("This is url")
      println(self.images.url)
        
      //Loading only one image so doing it this way
      //TODO: IS this correct way of only loading one image
        
      let imageURL = NSURL(string: self.images.url)
      if let imageData = NSData(contentsOfURL: imageURL!) {
      //self.userTimeLineHeader.set = UIImage(data: imageData)
        
      println("Almost ready to set background on this last controller")
      self.userTimeLineHeader.backgroundColor = UIColor(patternImage: UIImage(data: imageData)!)
        
      }

      
    })
    
    
    //this populates header
    self.lblUserTimeLineName.text = self.userTimeLineName
    self.lblUserTimeLineLocation.text = self.userTimeLineLocation
    
    self.userTimeLineTableView.dataSource = self
    self.userTimeLineTableView.estimatedRowHeight = 144
    self.userTimeLineTableView.rowHeight = UITableViewAutomaticDimension
    self.userTimeLineTableView.registerNib(UINib(nibName: "TweetCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "USER_CELL")
    self.networkController.fetchUserTimeline(self.userTimeLineId, completionHandler: { (tweets, errorDescription) -> () in
      self.tweets = tweets
      self.userTimeLineTableView.reloadData()
    })
    // Do any additional setup after loading the view.
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let tweets = self.tweets {
      return tweets.count
    } else {
      return 0
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = userTimeLineTableView.dequeueReusableCellWithIdentifier("USER_CELL", forIndexPath: indexPath) as CustomTableViewCell
    let tweet = self.tweets![indexPath.row]
    //cell.textLabel?.text = tweet.text
    cell.tweetLabel.text = tweet.text
    cell.usernameLabel.text = tweet.username
    if tweet.image == nil {
      self.networkController.fetchImageForTweet(tweet, completionHandler: { (image) -> () in
        //        self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        cell.tweetImageView.image = tweet.image
      })
    } else {
      cell.tweetImageView.image = tweet.image
    }
    
    return cell
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




    