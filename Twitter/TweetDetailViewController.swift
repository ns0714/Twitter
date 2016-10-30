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
    
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let tweet = tweet {
            profileImage.setImageWith((tweet.user?.profileUrl!)!)
            profileImage.layer.cornerRadius = 3
            
            fullName.text = tweet.user?.name
            handle.text = "@\(tweet.user?.screenName!)"
            tweetDescription.text = tweet.text
            createdDate.text = tweet.formattedTime
            retweetCount.text = "\(tweet.retweetCount ?? 0)"
            favoriteCount.text = "\(tweet.favoritesCount ?? 0)"
        }
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

}
