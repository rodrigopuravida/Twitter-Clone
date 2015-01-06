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

class ViewController: UIViewController, UITableViewDataSource {
  
  var tweets = [Tweet]()
  
  @IBOutlet weak var tweetTableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let myTwitterAccountStore = ACAccountStore()
    let myTwitterAccountType = myTwitterAccountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
    
    myTwitterAccountStore.requestAccessToAccountsWithType(myTwitterAccountType, options: nil) { (granted : Bool, error : NSError!) -> Void in
      if granted {
        let accounts = myTwitterAccountStore.accountsWithAccountType(myTwitterAccountType)
        if !accounts.isEmpty {
          let myTwitterAccount = accounts.first as ACAccount
          let requestURL = NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
          let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
          twitterRequest.account = myTwitterAccount
          twitterRequest.performRequestWithHandler(){ (data, response, error) -> Void in
            switch response.statusCode {
            case 200...299:
              println("this is great!")
              
              if let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: nil, error:nil) as? [AnyObject] {
                
                for object in jsonArray {
                  if let jsonDictionary = object as? [String : AnyObject] {
                    let tweet = Tweet(jsonDictionary)
                    self.tweets.append(tweet)
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                      
                      self.tweetTableView.reloadData()
                    })
                  }
                }
                
                
                
              }
              
            case 300...599:
              println("this is bad!")
            default:
              println("default case fired")
            }
            
          }
          
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

