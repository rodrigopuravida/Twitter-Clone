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
    
    //create my account Store
    let myTwitterAccountStore = ACAccountStore()
    //Of Type Twitter
    let myTwitterAccountType = myTwitterAccountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
    
    //request access but before make sure to set emulator to be able to access in the settings - CTRL - Shift H
    myTwitterAccountStore.requestAccessToAccountsWithType(myTwitterAccountType, options: nil) { (granted : Bool, error : NSError!) -> Void in
      //if account is validated
      if granted {
        let accounts = myTwitterAccountStore.accountsWithAccountType(myTwitterAccountType)
        if !accounts.isEmpty {
          //if there is actually an account
          let myTwitterAccount = accounts.first as ACAccount
          
          //bad url for testing bad request codes- missing last 'n'
          //let requestURL = NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.jso")
          
          
          // this rest api found here - https://dev.twitter.com/rest/public
          
          let requestURL = NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
          
          //sending the service request
          let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
          
          
          
          twitterRequest.account = myTwitterAccount
          
          //here comes the clousure that performs the 'in' section of code after response has been returned from the server
          twitterRequest.performRequestWithHandler(){ (data, response, error) -> Void in
            switch response.statusCode {
              
            //request is succesful
            case 200...299:
              
           
              if let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: nil, error:nil) as? [AnyObject] {
                
                for object in jsonArray {
                  if let jsonDictionary = object as? [String : AnyObject] {
                    
                    //instantiate a Tweet class
                    let tweet = Tweet(jsonDictionary)
                    
                    //add my Tweet object to array of tweets declared on top of class
                    self.tweets.append(tweet)
                    
                    //this code returns the interface operation to main thread which is the correct way to do this
                    
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                      
                      self.tweetTableView.reloadData()
                    })
                  }
                }
          
              }
              
            case 300...599:
              
              println("Twitter HTTP response \(response.statusCode)")
              
              
              //display my own alert message
              let alertController = UIAlertController(title: "Twitter HTTP response \(response.statusCode)", message:
                "Please Try Again", preferredStyle: UIAlertControllerStyle.Alert)
              alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
              
              self.presentViewController(alertController, animated: true, completion: nil)
              
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
    
    //this var name is what gets the value of user form within user dictionary which is within json
    let name = self.tweets[indexPath.row].user["name"] as String
    
    
    let tweet = self.tweets[indexPath.row]
    
    //this after adding CustomTableViewCell.swift - Day1

    cell.tweetCustomLabel.text = tweet.text + " by " + name
    
    //setting image background to blue so we can see the image
    cell.customImage.backgroundColor = UIColor.blueColor()
    
    
    //loading image from Tweet
    
    //variable referencing the image for each tweet
    let tweetImage = self.tweets[indexPath.row].user["profile_image_url"] as String
  
    let imageURL = NSURL(string: tweetImage)
    
    //adding images by converting code to  data and then to to image
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


}

