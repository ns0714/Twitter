//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Neha Samant on 11/1/16.
//  Copyright © 2016 Neha Samant. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var profilePictureView: UIImageView!
    @IBOutlet weak var twitterHandleView: UILabel!
    @IBOutlet weak var fullNameView: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var followingCountView: UILabel!
    
    var user: User!
    
    var tweets: [Tweet]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if user == nil {
            user = User.currentUser!
        }
        print("USER123", user.backgroundImageUrl!)
        backgroundImageView?.setImageWith((user.backgroundImageUrl!))
        profilePictureView?.setImageWith((user.profileUrl)!)
        profilePictureView.layer.cornerRadius = 3
        profilePictureView.layer.borderColor = UIColor.white.cgColor
        profilePictureView.layer.borderWidth = 2
        profilePictureView.layer.masksToBounds = true
        profilePictureView.clipsToBounds = true

        twitterHandleView.text = "@\((user.screenName)!)"
        fullNameView.text = user.name
        print("FOLLOERS", user.followersCount)
        followersCount?.text = String(describing: (user.followersCount))
        followingCountView?.text = String(describing: user.friendsCount)
        
        TwitterClient.sharedInstance?.getUserTimeline(screenName: (user?.screenName)!, success: { (tweets : [Tweet]) in
            self.tweets = tweets
            
            for tweet in self.tweets!{
                 print("@@@@@@@@@@@", tweet.user)
                 print("@@@@@@@@@@@", tweet.text)
            }
            
            self.tableView.reloadData()
            }, failure: { (error : Error) in
                print("ERROR: \(error.localizedDescription)")
        })
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        var tweet : Tweet?
        if (indexPath.row < tweets?.count ?? 0) {
            tweet = tweets?[indexPath.row]
            cell.tweet = tweet
        }
        return cell
    
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
