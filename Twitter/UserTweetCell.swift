//
//  UserTweetCell.swift
//  Twitter
//
//  Created by Neha Samant on 11/3/16.
//  Copyright © 2016 Neha Samant. All rights reserved.
//

import UIKit

class UserTweetCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var twitterHandleView: UILabel!
    @IBOutlet weak var tweetDescriptionView: UILabel!
    @IBOutlet weak var timeView: UILabel!
    @IBOutlet weak var replyImage: UIImageView!
    @IBOutlet weak var retweetImage: UIImageView!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var favoriteCount: UILabel!
    
    var tweet: Tweet! {
        didSet {
            print("Profile image", (tweet.user?.profileUrl)!)
            profileImageView?.setImageWith((tweet.user?.profileUrl)!)
            profileImageView?.layer.cornerRadius = 3
            profileImageView?.clipsToBounds = true
            nameView?.text = tweet.user?.name
            twitterHandleView?.text = "@\((tweet.user?.screenName)!)"
            timeView?.text = tweet.formattedRelativeTime
            tweetDescriptionView?.text = tweet.text
            retweetCount?.text = String(tweet.retweetCount)
            favoriteCount?.text = String(tweet.favoritesCount)
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
