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
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var numFavoritesLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    
    
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
                
                /*if(tweet.retweeted == true){
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
                }*/
                
        }
    

        // Do any additional setup after loading the view.
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
