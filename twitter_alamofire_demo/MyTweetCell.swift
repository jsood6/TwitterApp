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
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var numRetweetLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var numFavoriteLabel: UILabel!
    
    var tweet: Tweet! {
        didSet{
            tweetTextLabel.text = tweet.text
            usernameLabel.text = tweet.user.name
            screenNameLabel.text = "@" + tweet.user.screenName!
            userProfileImageView.af_setImage(withURL: URL(string: tweet.user.profile_image_url_string!)!)
            numRetweetLabel.text = "\(tweet.retweetCount)"
            numFavoriteLabel.text = "\(tweet.favoriteCount ?? 0)"
            
            /*if(tweet.retweeted == true){
                retweetButton.setImage(UIImage(named:"retweet-icon-green"), for: UIControlState.normal)
            }
            else{
                retweetButton.setImage(UIImage(named:"retweet-icon"), for: UIControlState.normal)
            }
            
            if(tweet.favorited == true){
                favoriteButton.setImage(UIImage(named:"favor-icon-red"), for: UIControlState.normal)
            }
            else{
                favoriteButton.setImage(UIImage(named:"favor-icon"), for: UIControlState.normal)
            }*/
        }
    }
    
    @IBAction func tapRetweetBtn(_ sender: Any) {
        if(tweet.retweeted == true){
            // TODO: Update the local tweet model
            tweet.retweeted = false
            tweet.retweetCount = tweet.retweetCount - 1
            //tweet.favoriteCount = 1
            // TODO: Update cell UI
            numRetweetLabel.text = String(describing: tweet.retweetCount)
            retweetButton.setImage(UIImage(named:"retweet-icon"), for: UIControlState.normal)
            
            // TODO: Send a POST request to the POST unretweet endpoint
            APIManager.shared.unRetweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
            
        }
            
        else{ //we want to favorite a tweet
            // TODO: Update the local tweet model
            tweet.retweeted = true
            tweet.retweetCount = tweet.retweetCount + 1
            
            // TODO: Update cell UI
            numRetweetLabel.text = String(describing: tweet.retweetCount )
            retweetButton.setImage(UIImage(named:"retweet-icon-green"), for: UIControlState.normal)
            
            // TODO: Send a POST request to the POST retweet endpoint
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
            
        }
    }
    
    @IBAction func tapFavorBtn(_ sender: Any) {
        if(tweet.favorited == true){ //we want to unfavorite a tweet
            print("unfavorite the tweet")
            tweet.favorited = false
            tweet.favoriteCount = tweet.favoriteCount! - 1
            numFavoriteLabel.text = String(describing: tweet.favoriteCount ?? 0)
            favoriteButton.setImage(UIImage(named:"favor-icon"), for: UIControlState.normal)
            
            // TODO: Send a POST request to the POST favorites/destrory endpoint
            APIManager.shared.unFavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
            
        }
        else{ //we want to favorite a tweet
            // TODO: Update the local tweet model
            tweet.favorited = true
            tweet.favoriteCount = tweet.favoriteCount! + 1
            
            // TODO: Update cell UI
            numFavoriteLabel.text = String(describing: tweet.favoriteCount ?? 0)
            favoriteButton.setImage(UIImage(named:"favor-icon-red"), for: UIControlState.normal)
            
            // TODO: Send a POST request to the POST favorites/create endpoint
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
            
            
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
