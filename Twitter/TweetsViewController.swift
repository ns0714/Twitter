//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Neha Samant on 10/27/16.
//  Copyright © 2016 Neha Samant. All rights reserved.
//

import UIKit
//import MBProgressHUD

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TweetComposeViewControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MBProgressHUD.appearance().tintColor = UIColor.white
        //MBProgressHUD.showAdded(to: self.view, animated: true)
        
        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(refreshControl:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        TwitterClient.sharedInstance?.getHomeTimeline(success: { (tweets : [Tweet]) in
            self.tweets = tweets
            
            for tweet in self.tweets!{
               // print("@@@@@@@@@@@", tweet.user)
               // print("@@@@@@@@@@@", tweet.text)
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
         return tweets?.count ?? 0
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
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        TwitterClient.sharedInstance?.getHomeTimeline(success: { (tweets : [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
            refreshControl.endRefreshing()
            }, failure: { (error : Error) in
                print("ERROR: \(error.localizedDescription)")
        })
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "tweetDetailSegue"){
            let cell = sender as! TweetCell
            let indexPath = tableView.indexPath(for: cell)
            let tweet = tweets![(indexPath! as NSIndexPath).row]
        
            let navigationController = segue.destination as! UINavigationController
            let tweetDetailViewController = navigationController.topViewController as! TweetDetailViewController
            tweetDetailViewController.tweet = tweet
        } else if (segue.identifier == "composeSegue") {
            let navigationController = segue.destination as! UINavigationController
            let composeViewController = navigationController.topViewController as! TweetComposeViewController
            composeViewController.delegate = self
        }
    }
    
    
    
    @IBAction func onLogoutButton(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.logout()
    }

    @IBOutlet weak var onComposeTweet: UIBarButtonItem!
    
    func tweetComposeViewController(tweetComposeViewController: TweetComposeViewController, didPostTweet tweetText: String!) {

        let tweet = Tweet(text: tweetText!)
        
        print("is it showing optional here", (tweet.text)!)
        TwitterClient.sharedInstance?.updateStatus(tweet: tweet, success: { (tweet) in
                self.tableView.reloadData()
            }, failure: { (error: Error) in
                print(error)
         })
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
