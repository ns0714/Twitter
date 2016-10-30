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
        
        let twitterClient = TwitterClient.sharedInstance
        twitterClient?.login(success: { print("GOT Token!")
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
            
            },
                             failure: { error in
                                print("ERROR: \(error.localizedDescription)")
        } )
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
