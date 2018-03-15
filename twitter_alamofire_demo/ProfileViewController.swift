//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by jsood on 3/14/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,ComposeViewControllerDelegate {
    
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var tableViewMyTweets: UITableView!
    @IBOutlet weak var numFollowersLabel: UILabel!
    @IBOutlet weak var numFollowingLabel: UILabel!
    @IBOutlet weak var numTweetsLabel: UILabel!
    
    var tweets: [Tweet] = []
    var refreshControl:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize a UIRefreshControl
        refreshControl = UIRefreshControl()
        
        //refreshActivityIndicator.startAnimating()
        
        refreshControl.addTarget(self, action: #selector(ProfileViewController.didPullToRefresh(_:)), for: .valueChanged)
        
        tableViewMyTweets.dataSource = self
        tableViewMyTweets.delegate = self
        
        tableViewMyTweets.rowHeight = 150
        tableViewMyTweets.insertSubview(refreshControl, at: 0)
        //tableViewMyTweets.rowHeight = UITableViewAutomaticDimension
        //tableViewMyTweets.estimatedRowHeight = 150
        
        if let user = User.current{
            usernameLabel.text = user.name
            screenNameLabel.text = "@" + user.screenName!
            profileImageView.af_setImage(withURL: URL(string:user.profile_image_url_string!)!)
            numTweetsLabel.text = "\(user.numTweets)"
            numFollowersLabel.text = "\(user.followers)"
            numFollowingLabel.text = "\(user.following)"
            print(user.backdrop_image_url_string!)
            backdropImageView.af_setImage(withURL: URL(string:user.backdrop_image_url_string!)!)
            
        }
        
        APIManager.shared.getUserTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableViewMyTweets.reloadData()
                
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
            self.refreshControl.endRefreshing()
        }

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTweetCell", for: indexPath) as! MyTweetCell
        
        cell.tweet = tweets[indexPath.row]
        
        return cell
    }
    
    func did(post: Tweet) {
        APIManager.shared.getUserTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableViewMyTweets.reloadData()
                self.refreshControl.endRefreshing()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        }
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl)
    {
        print("REFRESHING")
        APIManager.shared.getUserTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableViewMyTweets.reloadData()
                self.refreshControl.endRefreshing()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
            self.refreshControl.endRefreshing()
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
