//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

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
            /*if let userProfileURL = tweet.user.profile_image_url_string{
                self.userImageView.setURL(userProfileURL)
            }*/
            userImageView.af_setImage(withURL: URL(string: tweet.user.profile_image_url_string!)!)
            //userImageView.af_setImage(withURL: tweet.user.profile_image_url_string!)
        
            favoritesLabel.text = String(describing: tweet.favoriteCount ?? 0)
            
            if(tweet.retweeted == true){
                retweetBtn.setImage(UIImage(named:"retweet-icon-green"), for: UIControlState.normal)
            }
            else{
                retweetBtn.setImage(UIImage(named:"retweet-icon"), for: UIControlState.normal)
            }
            
            if(tweet.favorited == true){
                favoritesBtn.setImage(UIImage(named:"favor-icon-red"), for: UIControlState.normal)
            }
            else{
                favoritesBtn.setImage(UIImage(named:"favor-icon"), for: UIControlState.normal)
            }
            
        }
    }
    
    @IBAction func didTapFavorite(_ sender: Any) {
        
        if(tweet.favorited == true){ //we want to unfavorite a tweet
            print("unfavorite the tweet")
            tweet.favorited = false
            tweet.favoriteCount = tweet.favoriteCount! - 1
            favoritesLabel.text = String(describing: tweet.favoriteCount ?? 0)
            //favoritesBtn.setImage(UIImage(named:"favor-icon-red"), for: UIControlState.normal)
            
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
            favoritesLabel.text = String(describing: tweet.favoriteCount ?? 0)
            //favoritesBtn.setImage(UIImage(named:"favor-icon"), for: UIControlState.normal)
            
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
    
    @IBAction func didTapRetweet(_ sender: Any) {
        
        if(tweet.retweeted == true){
            // TODO: Update the local tweet model
            tweet.retweeted = false
            tweet.retweetCount = tweet.retweetCount - 1
            //tweet.favoriteCount = 1
            // TODO: Update cell UI
            retweetLabel.text = String(describing: tweet.retweetCount)
             //retweetBtn.setImage(UIImage(named:"retweet-icon-green"), for: UIControlState.normal)
            
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
            retweetLabel.text = String(describing: tweet.retweetCount )
             //retweetBtn.setImage(UIImage(named:"retweet-icon"), for: UIControlState.normal)
            
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
