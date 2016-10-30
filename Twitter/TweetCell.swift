//
//  TweetCell.swift
//  Twitter
//
//  Created by Neha Samant on 10/27/16.
//  Copyright © 2016 Neha Samant. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profilePictureView: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var twitterHandle: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoriteCOunt: UILabel!
    
    var tweet: Tweet! {
        didSet {
        profilePictureView?.setImageWith((tweet.user?.profileUrl)!)
        profilePictureView.layer.cornerRadius = 3
        fullName.text = tweet.user?.name
        twitterHandle.text = "@\((tweet.user?.screenName)!)"
        //time.text = tweet.timeStamp
        tweetText.text = tweet.text
        retweetCount.text = String(tweet.retweetCount)
        favoriteCOunt.text = String(tweet.favoritesCount)
    }
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
