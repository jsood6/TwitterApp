//
//  MyTweetCell.swift
//  twitter_alamofire_demo
//
//  Created by jsood on 3/14/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class MyTweetCell: UITableViewCell {

    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    var tweet: Tweet! {
        didSet{
            tweetTextLabel.text = tweet.text
            usernameLabel.text = tweet.user.name
            screenNameLabel.text = "@" + tweet.user.screenName!
            userProfileImageView.af_setImage(withURL: URL(string: tweet.user.profile_image_url_string!)!)
            
        }
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        userProfileImageView.layer.cornerRadius = 3
        userProfileImageView.clipsToBounds = true
        tweetTextLabel.preferredMaxLayoutWidth = tweetTextLabel.frame.size.width
        
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tweetTextLabel.preferredMaxLayoutWidth = tweetTextLabel.frame.size.width
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
