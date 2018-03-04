//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel! //property to store a tweet
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userScreenName: UILabel!
    @IBOutlet weak var datePostedLabel: UILabel!
    @IBOutlet weak var commentBtn: UIButton!
    
    @IBOutlet weak var messageBtn: UIButton!
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var favoritesBtn: UIButton!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var retweetBtn: UIButton!
    
    var tweet: Tweet! {
        //property observer
        didSet {
            tweetTextLabel.text = tweet.text
            usernameLabel.text = tweet.user.name
            userScreenName.text = "@" + tweet.user.screenName!
            datePostedLabel.text = tweet.createdAtString
            retweetLabel.text = "\(tweet.retweetCount)"
            if(tweet.favorited)!{
                favoritesLabel.text = String(describing: tweet.favoriteCount)
            }
            else{
                favoritesLabel.text = ""
            }
            
            if(retweetBtn.isSelected || tweet.favorited == true){
                retweetBtn.setImage(UIImage(named:"retweet-icon-green"), for: UIControlState.normal)
            }
            
            if(favoritesBtn.isSelected){
                favoritesBtn.setImage(UIImage(named:"favor-icon-red"), for: UIControlState.normal)
            }
            
        }
    }
    
    @IBAction func didTapFavorite(_ sender: Any) {
        // TODO: Update the local tweet model
        tweet.favorited = true
        tweet.favoriteCount = tweet.favoriteCount! + 1
        //tweet.favoriteCount = 1
        // TODO: Update cell UI
        favoritesLabel.text = String(describing: tweet.favoriteCount)
        
        // TODO: Send a POST request to the POST favorites/create endpoint
        APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error favoriting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully favorited the following Tweet: \n\(tweet.text)")
            }
        }
        
    }
    
    func refreshData() {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
