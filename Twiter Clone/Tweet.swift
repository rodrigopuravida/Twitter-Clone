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
  var image : String?
  var userId : String
  
  //the user is actually a dictionary so we need to create the user as a dictionary and figure out parsing later on the viewcontroller
  var user : [String : AnyObject]
  
  init( _ jsonDictionary : [String : AnyObject]) {
    self.text = jsonDictionary["text"] as String
    self.user = jsonDictionary["user"] as [String : AnyObject]
    self.image = user["profile_image_url"] as? String
    self.userId = jsonDictionary["id_str"] as String
  }
}

