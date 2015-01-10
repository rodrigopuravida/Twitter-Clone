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
  var userTimeLineId : String!
  var userTimeLineName : String!
  var userTimeLineImage : String!
  var userTimeLineLocation : String!
  var networkController : NetworkController!
  
  
  @IBOutlet weak var userTimeLineHeader: UIView!
  @IBOutlet weak var userTimeLineTableView: UITableView!
  @IBOutlet weak var lblUserTimeLine: UILabel!
  @IBOutlet weak var lblUserTimeLineName: UILabel!
  @IBOutlet weak var lblUserTimeLineLocation: UILabel!


  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    //this populates header
    self.lblUserTimeLineName.text = self.userTimeLineName
    //self.lblUserTimeLineLocation.text = self.userTimeLineLocation
    
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




    