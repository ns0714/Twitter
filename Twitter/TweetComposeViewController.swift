//
//  TweetComposeViewController.swift
//  Twitter
//
//  Created by Neha Samant on 10/29/16.
//  Copyright © 2016 Neha Samant. All rights reserved.
//

import UIKit

@objc protocol TweetComposeViewControllerDelegate {
    func tweetComposeViewController(tweetComposeViewController: TweetComposeViewController, didPostTweet tweetText: String!)
}

class TweetComposeViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var userProfilePicture: UIImageView!
    
    @IBOutlet weak var userHandle: UILabel!
    
    @IBOutlet weak var characterCount: UILabel!
    
    @IBOutlet weak var userFullName: UILabel!

    @IBOutlet weak var tweetText: UITextView!
    
    @IBOutlet weak var tweetButton: UIBarButtonItem!
   
    
    @IBOutlet weak var remainingCharacterCount: UIBarButtonItem!
    
    weak var delegate: TweetComposeViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = User.currentUser!
        self.automaticallyAdjustsScrollViewInsets = false
        userProfilePicture.setImageWith((user.profileUrl)!)
        userProfilePicture.layer.cornerRadius = 3
        userHandle.text = "@\((user.screenName)!)"
        userFullName.text = user.name
        tweetText.delegate = self
        tweetText.text = "What's happening"
        tweetText.textColor = UIColor.lightGray
        
    }

    public func textViewDidBeginEditing(_ textView: UITextView) {
        tweetText.becomeFirstResponder()
        if tweetText.textColor == UIColor.lightGray {
            tweetText.text = nil
            tweetText.textColor = UIColor.black
        }
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        updateRemainingCharacters()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onCancelButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onTweetButton(_ sender: AnyObject) {
        let newTweet = self.tweetText.text!
        delegate?.tweetComposeViewController(tweetComposeViewController: self, didPostTweet: newTweet)
        dismiss(animated: true, completion: nil)
    }
    
    func updateRemainingCharacters() {
        let tweetTextCount = tweetText.text?.characters.count ?? 0
        remainingCharacterCount.title = "\(140 - tweetTextCount)"
        
        if(tweetTextCount > 140) {
            tweetButton.isEnabled = false
        }else {
            tweetButton.isEnabled = true
        }
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
