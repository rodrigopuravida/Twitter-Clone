//
//  CustomTableViewCell.swift
//  Twiter Clone
//
//  Created by Rodrigo Carballo on 1/5/15.
//  Copyright (c) 2015 Rodrigo Carballo. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

  @IBOutlet weak var tweetLabel: UILabel!
  @IBOutlet weak var usernameLabel: UILabel!
  
  
  @IBOutlet weak var tweetImageView: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  //fix for automatic height issue
  override func layoutSubviews() {
    super.layoutSubviews()
    self.contentView.layoutIfNeeded()
    self.tweetLabel.preferredMaxLayoutWidth = self.tweetLabel.frame.width
    
  }
  
  

}
