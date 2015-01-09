//
//  UserTimelineViewController.swift
//  Twiter Clone
//
//  Created by Rodrigo Carballo on 1/8/15.
//  Copyright (c) 2015 Rodrigo Carballo. All rights reserved.
//

import UIKit

class UserTimelineViewController: UIViewController {
  
  var tweets : [Tweet]!
  var userTimeLineId : String!
  var networkController : NetworkController!
  
  
  @IBOutlet weak var lblUserTimeLine: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
      
      
      self.networkController.fetchUserTimeline(self.userTimeLineId, completionHandler: { (tweets, errorDescription) -> () in
      })


        //Call this method
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
