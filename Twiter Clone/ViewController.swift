//
//  ViewController.swift
//  Twiter Clone
//
//  Created by Rodrigo Carballo on 1/5/15.
//  Copyright (c) 2015 Rodrigo Carballo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
  
  var tweets = [Tweet]()
  
  @IBOutlet weak var tweetTableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    if let jsonPath = NSBundle.mainBundle().pathForResource("tweet", ofType: "json") {
      
      if let jsonData = NSData(contentsOfFile: jsonPath) {
        var error : NSError?
        
        if let jsonArray = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error:&error) as? [AnyObject] {
          for object in jsonArray {
            if let jsonDictionary = object as? [String: AnyObject] {
              
              let tweet = Tweet(jsonDictionary)
              self.tweets.append(tweet)
              
              }
          }
          
          //this is just a test
//          for var i = 0; i < tweets.count; i++ {
//            println(self.tweets[i].text)
//            println(self.tweets[i].user["name"])
//            
//          }
          
          //testing git
          
        }
      
    }
    
  }
    
    self.tweetTableView.dataSource = self
}
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.tweets.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TWEET_CELL", forIndexPath: indexPath) as CustomTableViewCell
    var name = self.tweets[indexPath.row].user["name"] as String
    let tweet = self.tweets[indexPath.row]
    
    //this before adding CustomTableViewCell.swift
    
    //cell.textLabel?.text = tweet.text + " by " + name
    cell.tweetCustomLabel.text = tweet.text + " by " + name
    cell.customImage.backgroundColor = UIColor.blueColor()
    
    
    return cell
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

