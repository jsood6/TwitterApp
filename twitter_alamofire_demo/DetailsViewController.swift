//
//  DetailsViewController.swift
//  twitter_alamofire_demo
//
//  Created by jsood on 3/6/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userScreenName: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var numRetweetsLabel: UILabel!
    
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var numFavoritesLabel: UILabel!
    
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favoritesBtn: UIButton!
    
    @IBOutlet weak var retweetBtn: UIButton!
    
    var tweet: Tweet?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tweet=tweet{
            print("HERE!!!!")
                tweetTextLabel.text = tweet.text
                username.text = tweet.user.name
                userScreenName.text = "@" + tweet.user.screenName!
                dateLabel.text = tweet.createdAtString
                numRetweetsLabel.text = "\(tweet.retweetCount)"
                /*if let userProfileURL = tweet.user.profile_image_url_string{
                 self.userImageView.setURL(userProfileURL)
                 }*/
                userProfileImage.af_setImage(withURL: URL(string: tweet.user.profile_image_url_string!)!)
                //userImageView.af_setImage(withURL: tweet.user.profile_image_url_string?)
                //userImageView.af_setImage(withURL: tweet.user.profile_image_url_string!)
                
                numFavoritesLabel.text = String(describing: tweet.favoriteCount ?? 0)
                
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
    

        // Do any additional setup after loading the view.
    }

    @IBAction func tapRetweetBtn(_ sender: Any) {
        if(tweet?.retweeted == true){
            // TODO: Update the local tweet model
            tweet?.retweeted = false
            tweet?.retweetCount = (tweet?.retweetCount)! - 1
            //tweet.favoriteCount = 1
            // TODO: Update cell UI
            numRetweetsLabel.text = String(describing: tweet?.retweetCount)
            retweetBtn.setImage(UIImage(named:"retweet-icon"), for: UIControlState.normal)
            
            // TODO: Send a POST request to the POST unretweet endpoint
            APIManager.shared.unRetweet(tweet!) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
            
        }
            
        else{ //we want to favorite a tweet
            // TODO: Update the local tweet model
            tweet?.retweeted = true
            tweet?.retweetCount = (tweet?.retweetCount)! + 1
            
            // TODO: Update cell UI
            numRetweetsLabel.text = String(describing: tweet?.retweetCount )
            retweetBtn.setImage(UIImage(named:"retweet-icon-green"), for: UIControlState.normal)
            
            // TODO: Send a POST request to the POST retweet endpoint
            APIManager.shared.retweet(tweet!) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
            
        }
    }
    
    @IBAction func tapFavoritesBtn(_ sender: Any) {
        if(tweet?.favorited == true){ //we want to unfavorite a tweet
            print("unfavorite the tweet")
            tweet?.favorited = false
            tweet?.favoriteCount = (tweet?.favoriteCount!)! - 1
            numFavoritesLabel.text = String(describing: tweet?.favoriteCount ?? 0)
            favoritesBtn.setImage(UIImage(named:"favor-icon"), for: UIControlState.normal)
            
            // TODO: Send a POST request to the POST favorites/destrory endpoint
            APIManager.shared.unFavorite(tweet!) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
            
        }
        else{ //we want to favorite a tweet
            // TODO: Update the local tweet model
            tweet?.favorited = true
            tweet?.favoriteCount = (tweet?.favoriteCount!)! + 1
            
            // TODO: Update cell UI
            numFavoritesLabel.text = String(describing: tweet?.favoriteCount ?? 0)
            favoritesBtn.setImage(UIImage(named:"favor-icon-red"), for: UIControlState.normal)
            
            // TODO: Send a POST request to the POST favorites/create endpoint
            APIManager.shared.favorite(tweet!) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
            
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
