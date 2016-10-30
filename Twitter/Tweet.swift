//
//  Tweet.swift
//  Twitter
//
//  Created by Neha Samant on 10/25/16.
//  Copyright © 2016 Neha Samant. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var text: String!
    var timeStamp: Date?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    
    var user: User?
    
    var isFavorited = false
    var isRetweeted = false
    
    init(dictionary: NSDictionary) {
        text = (dictionary["text"] as? String)!
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        user = User.init(dictionary: dictionary["user"] as! NSDictionary)
    
        let timestampString = dictionary["created_at"] as? String
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        
        if let timestampString = timestampString {
            timeStamp = formatter.date(from: timestampString)
            print("###############", timeStamp)
        }
    }
    
    init(text: String!) {
        self.text = text
        retweetCount = 0
        favoritesCount = 0
        user = User.currentUser
        timeStamp = Date()
    }
    
    var formattedTime: String? {
        get {
            if let timestamp = timeStamp {
                let formatter = DateFormatter()
                formatter.dateStyle = DateFormatter.Style.long
                formatter.timeStyle = DateFormatter.Style.short
                return formatter.string(from: timestamp)
            }
            return nil
        }
    }
    var formattedRelativeTime: String? {
        get {
            if let timestamp = timeStamp {
                let formatter = DateComponentsFormatter()
                formatter.unitsStyle = DateComponentsFormatter.UnitsStyle.abbreviated
                formatter.includesApproximationPhrase = false
                formatter.includesTimeRemainingPhrase = false
                formatter.allowedUnits = [.second, .minute, .hour, .day]
                formatter.maximumUnitCount = 1
                return formatter.string(from: timestamp, to: NSDate() as Date)
            }
            return nil
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        return tweets
    }
}
