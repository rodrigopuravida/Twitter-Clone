//
//  NetworkController.swift
//  Twiter Clone
//
//  Created by Rodrigo Carballo on 1/7/15.
//  Copyright (c) 2015 Rodrigo Carballo. All rights reserved.
//

import Foundation
import Accounts
import Social

class NetworkController {
  
  // TODO: Fix alert for status codes that don't work
  
  var myTwitterAccount : ACAccount?
  var imageQueue = NSOperationQueue()
  
  
  init() {
    
  }
  
  func fetchTwitterHomeTimeline( completionHandler : ([Tweet]?, String?) -> ()) {
  
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
          self.myTwitterAccount = accounts.first as? ACAccount
          
          // this rest api found here - https://dev.twitter.com/rest/public
          
          let requestURL = NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
          //println(requestURL)
          
          //sending the service request
          let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
          
       
          twitterRequest.account = self.myTwitterAccount
          
          //here comes the clousure that performs the 'in' section of code after response has been returned from the server
          twitterRequest.performRequestWithHandler(){ (data, response, error) -> Void in
            switch response.statusCode {
              
              //request is succesful
            case 200...299:
              
              
              if let jsonDict = NSJSONSerialization.JSONObjectWithData(data, options: nil, error:nil) as? [AnyObject] {
                
                var tweets = [Tweet]()
                for object in jsonDict {
                  if let jsonDictionary = object as? [String : AnyObject] {
                    
                    //instantiate a Tweet class
                    let tweet = Tweet(jsonDictionary)
                    
                    //add my Tweet object to array of tweets declared on top of class
                    tweets.append(tweet)

                  }
                }
                
                //this code returns the interface operation to main thread which is the correct way to do this
                //now is calling completion handler
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                  completionHandler(tweets, nil)
                })
                
              }
              
            case 300...599:
              
              println("Twitter HTTP response \(response.statusCode)")
              
              
              //display my own alert message
              let alertController = UIAlertController(title: "Twitter HTTP response \(response.statusCode)", message:
                "Please Try Again", preferredStyle: UIAlertControllerStyle.Alert)
              alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
              
              //presentViewController(alertController, animated: true, completion: nil)
              
            default:
              println("default case fired")
            }
            
          }
          
        }
      }
      
    }
    
  }
  
  func fetchDetailsOnTweet( id : String, completionHandler : ([String : AnyObject]?, String?) -> ()) {
    
          //accesing individual tweet with concatenation of user id
          
          let requestURL = NSURL(string: "https://api.twitter.com/1.1/statuses/show.json?id=\(id)")
          //println(requestURL)
          
          //sending the service request
          let detaiTtwitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
          
          
          detaiTtwitterRequest.account = myTwitterAccount
          
          detaiTtwitterRequest.performRequestWithHandler(){ (data, response, error) -> Void in
            
            switch response.statusCode {
              
              //request is succesful
            case 200...299:
              
              if let jsonDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error:nil) as? [String : AnyObject] {
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                  completionHandler(jsonDictionary, nil)
                })
              }
            case 300...599:
              
              
              
              //display my own alert message
              let alertController = UIAlertController(title: "Twitter HTTP response \(response.statusCode)", message:
                "Please Try Again", preferredStyle: UIAlertControllerStyle.Alert)
              alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
              
              //presentViewController(alertController, animated: true, completion: nil)
              
            default:
              println("default case fired")
            }

          }  }
  
  
  func fetchUserTimeline(id : String, completionHandler : ([Tweet]?, String?) -> ()) {
    
          let requestURL = NSURL(string: "https://api.twitter.com/1.1/statuses/user_timeline.json?user_id=\(id)")!
          println(requestURL)
          
          //sending the service request
          let detaiTtwitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
          
          detaiTtwitterRequest.account = self.myTwitterAccount
          
          detaiTtwitterRequest.performRequestWithHandler(){ (data, response, error) -> Void in
            
            
            switch response.statusCode {
              
              //request is succesful
            case 200...299:
              
              println("Twitter HTTP response \(response.statusCode)")
              if let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: nil, error:nil) as? [AnyObject] {
                
                var tweets = [Tweet]()
                for object in jsonArray {
                  if let jsonDictionary = object as? [String : AnyObject] {
                    
                    //instantiate a Tweet class
                    let tweet = Tweet(jsonDictionary)
                    
                    //add my Tweet object to array of tweets declared on top of class
                    tweets.append(tweet)
                    
                  }
                }

                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                  completionHandler(tweets, nil)
                })
              }
              
            case 300...599:
              
              println("Twitter HTTP response \(response.statusCode)")
              
              //display my own alert message
              let alertController = UIAlertController(title: "Twitter HTTP response \(response.statusCode)", message:
                "Please Try Again", preferredStyle: UIAlertControllerStyle.Alert)
              alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
              
              //presentViewController(alertController, animated: true, completion: nil)
              
            default:
              println("default case fired")
            }
        }
  }
  
  
  
  func fetchUserBackgroundImage(id : String, completionHandler : ([Tweet]?, String?) -> ()) {
    
    let requestURL = NSURL(string: "https://api.twitter.com/1.1/users/profile_banner.json?user_id=\(id)")!
    println(requestURL)
    
    //sending the service request
    let detaiTtwitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
    
    detaiTtwitterRequest.account = self.myTwitterAccount
    
    detaiTtwitterRequest.performRequestWithHandler(){ (data, response, error) -> Void in
      
      
      switch response.statusCode {
        
        //request is succesful
      case 200...299:
        
        //let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: nil, error:nil) as? [String : AnyObject]
        //println(jsonArray)
        
        
        println("Twitter HTTP response \(response.statusCode)")
        if let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: nil, error:nil) as? [String : AnyObject] {
        
        
        
//          var tweets = [Tweet]()
//          for object in jsonArray {
//            if let jsonDictionary = object as? [String : AnyObject] {
//              
//              //instantiate a Tweet class
//              let tweet = Tweet(jsonDictionary)
//              
//              //add my Tweet object to array of tweets declared on top of class
//              tweets.append(tweet)
//              
//            }
//          }
        
//          NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
//            completionHandler(tweets, nil)
//          })
        }
        
      case 300...599:
        
        println("Twitter HTTP response \(response.statusCode)")
        
      default:
        println("default case fired")
      }
    }
  }

  
  
  
  
  
  
  
  
  
  
  //this only called if image is not present
  func fetchImageForTweet(tweet : Tweet, completionHandler: (UIImage?) -> ()) {
    //image download
    if let imageURL = NSURL(string: tweet.imageURL!) {
      self.imageQueue.addOperationWithBlock({ () -> Void in
        
        if let imageData = NSData(contentsOfURL: imageURL) {
          tweet.image = UIImage(data: imageData)
          NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
            completionHandler(tweet.image)
          })
          
        }
        
      })
    }
  }  

}
