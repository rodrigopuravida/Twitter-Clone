//
//  UserTimelineViewController.swift
//  Twiter Clone
//
//  Created by Rodrigo Carballo on 1/8/15.
//  Copyright (c) 2015 Rodrigo Carballo. All rights reserved.
//

import UIKit

class UserTimelineViewController: UIViewController {
  
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
      
      self.lblUserTimeLineName.text = self.userTimeLineName
      self.lblUserTimeLineLocation.text = self.userTimeLineLocation
      
      
      
      
      //self.userTimeLineTableView.dataSource = self
      
      self.networkController.fetchUserTimeline(self.userTimeLineId, completionHandler: { (tweets, errorDescription) -> () in
        
        
        
        

//        self.tweets = tweets
//        self.userTimeLineTableView.reloadData()
//        
      })
     
//      func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if let tweets = self.tweets {
//          return tweets.count
//        }
//        else {
//          return 0
//        }
//      }
      
//      func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = userTimeLineTableView.dequeueReusableCellWithIdentifier("USER_TIMELINE_CELL", forIndexPath: indexPath) as CustomTableViewCell
//        let tweet = self.tweets![indexPath.row]
//        
//        return cell
//        
//      }
  
      
  
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
