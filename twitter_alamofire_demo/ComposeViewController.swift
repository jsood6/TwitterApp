//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by jsood on 3/14/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

protocol ComposeViewControllerDelegate {
    func did(post: Tweet)
}

class ComposeViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var wordCount: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var tweetTextView: UITextView!
    
    
    var delegate: ComposeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.delegate = (self as UITextViewDelegate)
        wordCount.text = "140"
        if let user = User.current{
            userProfileImage.af_setImage(withURL: URL(string:user.profile_image_url_string!)!)
            usernameLabel.text = user.name
            screenNameLabel.text = "@" + user.screenName!
        }
        
        /*let countNotReached = textView(tweetTextView, shouldChangeTextIn: nil, replacementText: tweetTextView.text)
        tweetTextView.endEditing(true)
        
        if(countNotReached == true){
            wordCount.text = "\(0) words"
        }
        else{
            wordCount.text = "word limit reached"
        }*/
        
        
        

        // Do any additional setup after loading the view.
    }
    
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // TODO: Check the proposed new text character count
        // Allow or disallow the new text
        // Set the max character limit
        let characterLimit = 140
        
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        wordCount.text = "\(characterLimit - newText.characters.count)"
        
        // TODO: Update Character Count Label
        
        // The new text should be allowed? True/False
        return newText.characters.count < characterLimit
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapPost(_ sender: Any) {
        APIManager.shared.composeTweet(with: tweetTextView.text) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        
    }
    
    
    @IBAction func didTapCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
