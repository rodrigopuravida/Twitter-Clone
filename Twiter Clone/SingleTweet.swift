//
//  SingleTweet.swift
//  Twiter Clone
//
//  Created by Rodrigo Carballo on 1/7/15.
//  Copyright (c) 2015 Rodrigo Carballo. All rights reserved.
//

import Foundation
import UIKit

class SingeTweet {
  var userId : String
  
  
  //the user is actually a dictionary so we need to create the user as a dictionary and figure out parsing later on the viewcontroller
 
  
  init( _ singleTweetArray : [String : AnyObject]) {
    
    self.userId = singleTweetArray["id_str"] as String

  }
  
}
