//
//  BackGroundImage.swift
//  Twiter Clone
//
//  Created by Rodrigo Carballo on 1/10/15.
//  Copyright (c) 2015 Rodrigo Carballo. All rights reserved.
//

import Foundation
import UIKit

class BackGroundImage {
  
  var sizes : String
  var platform : [String : AnyObject]
  var url : String
  
  init( _ jsonDictionary : [String : AnyObject]) {
    
    self.sizes = jsonDictionary["sizes"] as String
    self.platform = jsonDictionary["mobile"] as [String: AnyObject]
    self.url   = platform["url"] as String

  }
}
