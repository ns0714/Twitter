//
//  User.swift
//  Twitter
//
//  Created by Neha Samant on 10/25/16.
//  Copyright © 2016 Neha Samant. All rights reserved.
//

import UIKit

class User: NSObject {
    
    static let currentUserKey = "currentUserData"
    static let userDidLogoutNotification = "UserDidLogout"
    
    var name: String?
    var screenName: String?
    var profileUrl: URL?
    var backgroundImageUrl: URL?
    var tagLine: String?
    var followersCount: Int = 0
    var friendsCount: Int = 0
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)
            print("!!!!!!!!!PR", profileUrl)
        }
        
       /* let backgroundUrlString = dictionary["profile_background_image_url"] as? String
        if let backgroundUrlString = backgroundUrlString {
            backgroundImageUrl = URL(string: backgroundUrlString)
            print("!!!!!!!!!BI", backgroundImageUrl)
        }*/
        
        let imageUrl = dictionary["profile_background_image_url_https"] as? String
        if let imageUrl = imageUrl {
            backgroundImageUrl = URL(string: imageUrl)
            print("##############", backgroundImageUrl)
        }
        
        followersCount = (dictionary["followers_count"] as? Int) ?? 0
        friendsCount = (dictionary["friends_count"] as? Int) ?? 0
        
        print("@@@@@@@@@@FOL", followersCount)
        print("@@@@@@@@@FRIEN", friendsCount)
        
        tagLine = dictionary["description"] as? String
    }
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: User.currentUserKey) as? NSData
                
                if let userData = userData {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData as Data, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        
        
        set(user) {
            _currentUser = user
            
            let defaults = UserDefaults.standard
            
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: User.currentUserKey)
            }else {
                defaults.set(nil, forKey: User.currentUserKey)
            }
            defaults.synchronize()
        }
    }
        
//        set(user) {
//            let userDefaults = UserDefaults.standard
//            if let user = user {
//                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
//                userDefaults.set(data, forKey: User.currentUserStorageKey)
//            } else {
//                userDefaults.set(nil, forKey: User.currentUserStorageKey)
//            }
//            
//            userDefaults.synchronize()
//        }
//    }
//    
}
