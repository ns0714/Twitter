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
    @IBOutlet weak var favoriteCount: UILabel!
    @IBOutlet weak var retweetImage: UIImageView!
    @IBOutlet weak var replyImage: UIImageView!
    @IBOutlet weak var favoriteImage: UIImageView!
    
    var tweet: Tweet! {
        didSet {
        profilePictureView?.setImageWith((tweet.user?.profileUrl)!)
        profilePictureView.layer.cornerRadius = 3
        profilePictureView.clipsToBounds = true
        fullName.text = tweet.user?.name
        twitterHandle.text = "@\((tweet.user?.screenName)!)"
        time.text = tweet.formattedRelativeTime
        tweetText.text = tweet.text
        retweetCount.text = String(tweet.retweetCount)
        favoriteCount.text = String(tweet.favoritesCount)
    }
}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tapRetweet = UITapGestureRecognizer(target: self, action: Selector(("tappedRetweet")))
        retweetImage.addGestureRecognizer(tapRetweet)
        retweetImage.isUserInteractionEnabled = true
        
        let tapFavorite = UITapGestureRecognizer(target: self, action: Selector(("tappedFavorite")))
        favoriteImage.addGestureRecognizer(tapFavorite)
        favoriteImage.isUserInteractionEnabled = true
    }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func tappedRetweet() {
        var count = tweet.retweetCount
        if tweet.isRetweeted {
            print("Tapped on RETWEET Image")
            retweetImage.image = UIImage(named: "retweet_off_icon")
            retweetCount.text = "\(count)"
            tweet.isRetweeted = false
        }else {
            print("Tapped on RETWEET Image")
            retweetImage.image = UIImage(named: "retweet_on")
            retweetCount.text = "\(count+1)"
            tweet.isRetweeted = true
        }
    }
    
    func tappedFavorite() {
        var count = tweet.favoritesCount
        if tweet.isFavorited {
            print("Tapped on FAV Image")
            favoriteImage.image = UIImage(named: "favorite_off_icon")
            favoriteCount.text = "\(count)"
            tweet.isFavorited = false
        }else {
            print("Tapped on FAV Image")
            favoriteImage.image = UIImage(named: "favorite_on")
            favoriteCount.text = "\(count+1)"
            tweet.isFavorited = true
        }
    }
}
