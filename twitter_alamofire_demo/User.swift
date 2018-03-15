//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/17/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

class User {
    
    //properties
    var name: String
    var screenName: String?
    var followers: Int
    var following: Int
    var numTweets: Int
    static var current: User?
    var userDict: [String: Any]!
    var profile_image_url_string: String?
    var backdrop_image_url_string: String?
    
    //initializer
    init(dictionary: [String: Any]) {
        name = dictionary["name"] as! String
        screenName = dictionary["screen_name"] as? String
        self.userDict = dictionary
        profile_image_url_string = dictionary["profile_image_url_https"] as? String //get access to the profile image of the user for each tweet
        
        backdrop_image_url_string = dictionary["profile_banner_url"] as? String
        
        followers = dictionary["followers_count"] as! Int
        following = dictionary["friends_count"] as! Int
        numTweets = dictionary["statuses_count"] as! Int
        

    }
}
