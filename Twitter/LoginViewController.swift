//
//  LoginViewController.swift
//  Twitter
//
//  Created by Neha Samant on 10/25/16.
//  Copyright © 2016 Neha Samant. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(_ sender: AnyObject) {
        
        let twitterClient = BDBOAuth1SessionManager(baseURL: URL(string: "https://api.twitter.com")!, consumerKey: "fOz35RDrCMCinbI2HD8vGxiUD", consumerSecret: "xDwcUqClQVM53oVeLfDDUMaCYsuX2VnG2AZZcK1aNTE9UutHjr")
        twitterClient?.deauthorize()
        
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: nil, scope: nil, success: { (requestToken :BDBOAuth1Credential?) ->Void in
            print("I came here \(requestToken?.token)")
            
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken?.token)")!
            UIApplication.shared.openURL(url)
            }, failure: { (error: Error?) in
                print("error")
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
