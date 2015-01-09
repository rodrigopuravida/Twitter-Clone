//
//  Tweet.swift
//  Twiter Clone
//
//  Created by Rodrigo Carballo on 1/5/15.
//  Copyright (c) 2015 Rodrigo Carballo. All rights reserved.
//

import Foundation
import UIKit

class Tweet {
  var text : String
  var imageURL : String?
  var userId : String
  var username : String
  var detailedTweetText : String?
  var screenName : String?
  var image : UIImage?
  var favoriteCount : String?
  var userTimeLineID : String?
  var userTimeLineName : String?
  
  
  //profile_background_image_url_https
  
  //the user is actually a dictionary so we need to create the user as a dictionary and figure out parsing later on the viewcontroller
  var user : [String : AnyObject]
  
  init( _ jsonDictionary : [String : AnyObject]) {
    self.text = jsonDictionary["text"] as String
    self.user = jsonDictionary["user"] as [String : AnyObject]
    self.userTimeLineID = user["id_str"] as? String
    self.imageURL = user["profile_image_url"] as? String
    self.userId = jsonDictionary["id_str"] as String
    self.username = user["name"] as String
    self.userTimeLineName = user["name"] as? String
    
  }
  
  func updateWithInfo(infoDictionary : [String : AnyObject]) {
    self.detailedTweetText = infoDictionary["text"] as? String
    self.screenName = infoDictionary["screen_name"] as? String
    let favoriteCountNumber = infoDictionary["favorite_count"] as Int
    self.favoriteCount = "\(favoriteCountNumber)"
   }
}

