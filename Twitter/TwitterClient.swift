//
//  TwitterClient.swift
//  Twitter
//
//  Created by Neha Samant on 10/25/16.
//  Copyright © 2016 Neha Samant. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {

    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com")!, consumerKey: "fOz35RDrCMCinbI2HD8vGxiUD", consumerSecret: "xDwcUqClQVM53oVeLfDDUMaCYsuX2VnG2AZZcK1aNTE9UutHjr")
    
    var loginSuccess : (() -> ())?
    var loginFailure : ((Error) -> ())?
    
    func getHomeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task:URLSessionDataTask, response: Any?) -> Void in
            print("account: \(response)")
            
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            success(tweets)
            }, failure: { (task: URLSessionDataTask?, error: Error?) -> Void in
                failure(error!)
        })
    }
    
    func getCurrentAccount(success: @escaping (User) -> (), failure: ((NSError) -> ())?) {
        get("1.1/account/verify_credentials.json",
            parameters: nil,
            progress: nil,
            success: { (task: URLSessionDataTask, response: Any?) in
                let userDictionary = response as!  NSDictionary
                let user = User(dictionary: userDictionary)
                success(user)
            },
            failure: { (task: URLSessionDataTask?, error: Error) in
                failure?(error as NSError)
        })
    }
    
    func login(success: @escaping () -> (), failure : @escaping (Error) -> ()) {
        loginSuccess = success
        loginFailure = failure
        TwitterClient.sharedInstance?.deauthorize()
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitterdemo://oauth"), scope: nil, success: { (requestToken :BDBOAuth1Credential?) ->Void in
            
            let token: String! = requestToken?.token!
            print("I came here \(token!)")
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(token!)")!
            UIApplication.shared.openURL(url)
                                                                
            },
            failure: {(error: Error?) -> Void in
            print("error: \(error?.localizedDescription)")
            self.loginFailure?(error!)
        })
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
    }
    
    
    func updateStatus(tweet: Tweet, success: @escaping (Tweet) -> (), failure: @escaping (NSError) -> ()) {
        post("1.1/statuses/update.json",
             parameters: ["status": tweet.text],
             progress: nil,
             success: { (NSURLSessionDataTask, response: Any?) in
                let tweet = Tweet(dictionary: response as! NSDictionary)
                success(tweet)
        }) { (task: URLSessionDataTask?, error: Error) in
            failure(error as NSError)
        }
    }
    
    
    func handleOpenURL(url : URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        let twitterClient = TwitterClient.sharedInstance
        twitterClient?.fetchAccessToken(withPath: "oauth/access_token",
                                        method: "POST",
                                        requestToken: requestToken,
                                        success: {(accessToken: BDBOAuth1Credential?) -> Void in
                                            self.getCurrentAccount(success: { (user: User) in
                                                 User.currentUser = user
                                                self.loginSuccess?()
                                                }, failure: { (error : Error?) in
                                                    self.loginFailure?(error!)
                                            })
                                            
            }, failure : { (error : Error?) -> Void in
                print("error: \(error?.localizedDescription)")
                self.loginFailure?(error!)
            }
        )
    }

}
