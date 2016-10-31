//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by Neha Samant on 10/28/16.
//  Copyright © 2016 Neha Samant. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

    
   
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var handle: UILabel!
    @IBOutlet weak var tweetDescription: UILabel!
    @IBOutlet weak var createdDate: UILabel!
    @IBOutlet weak var createdTime: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoriteCount: UILabel!

    @IBOutlet weak var replyImage: UIImageView!
    
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var retweetImage: UIImageView!
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let tweet = tweet {
            profileImage.setImageWith((tweet.user?.profileUrl!)!)
            profileImage.layer.cornerRadius = 3
            profileImage.clipsToBounds = true
            fullName.text = tweet.user?.name
            handle.text = "@\((tweet.user?.screenName)!)"
            tweetDescription.text = tweet.text
            createdDate.text = tweet.formattedTime
            print("RETWEEET",tweet.retweetCount)
            print("FAVORITE",tweet.favoritesCount)
            retweetCount.text = "\(tweet.retweetCount ?? 0)"
            favoriteCount.text = "\(tweet.favoritesCount ?? 0)"
        }
        
        let tapRetweet = UITapGestureRecognizer(target: self, action: Selector(("tappedRetweet")))
        retweetImage.addGestureRecognizer(tapRetweet)
        retweetImage.isUserInteractionEnabled = true
        
        let tapFavorite = UITapGestureRecognizer(target: self, action: Selector(("tappedFavorite")))
        favoriteImage.addGestureRecognizer(tapFavorite)
        favoriteImage.isUserInteractionEnabled = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onCancelButton(_ sender: AnyObject) {
         dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tappedRetweet() {
        var count = tweet?.retweetCount
        if (tweet?.isRetweeted)! {
            print("Tapped on RETWEET Image")
            retweetImage.image = UIImage(named: "retweet_off_icon")
            retweetCount.text = "\((tweet?.retweetCount)!)"
            tweet?.isRetweeted = false
        }else {
            print("Tapped on RETWEET Image")
            retweetImage.image = UIImage(named: "retweet_on")
            retweetCount.text = "\(count!+1)"
            tweet?.isRetweeted = true
        }
    }
    
    func tappedFavorite() {
        var count = tweet?.favoritesCount
        if (tweet?.isFavorited)! {
            print("Tapped on FAV Image")
            favoriteImage.image = UIImage(named: "favorite_off_icon")
            favoriteCount.text = "\((tweet?.favoritesCount)!)"
            tweet?.isFavorited = false
        }else {
            print("Tapped on FAV Image")
            favoriteImage.image = UIImage(named: "favorite_on")
            favoriteCount.text = "\(count!+1)"
            tweet?.isFavorited = true
        }
    }


}
