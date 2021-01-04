//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit
import SwifteriOS
import CoreML
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!

    let sentimentClassifier = TweetSentimentClassifer()
    
    let swifter = Swifter(consumerKey: "", consumerSecret: "")

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func predictPressed(_ sender: Any) {
        if let searchText = textField.text {
            swifter.searchTweet(using: searchText, lang: "en",count: 100, tweetMode: .extended) { (results, metaData) in
                var tweets = [TweetSentimentClassiferInput]()
                
                for i in 0..<100 {
                    if let tweet = results[i]["full_text"].string {
                        let tweetForClassification =  TweetSentimentClassiferInput(text: tweet)
                        tweets.append(tweetForClassification)
                    }
                }
                do {
                    let predictions = try self.sentimentClassifier.predictions(inputs: tweets)
                    var sentimentScore = 0
                    for prediction in predictions {
                        let sentiment = prediction.label
                        if sentiment == "Pos" {
                            sentimentScore += 1
                        } else if sentiment == "Neg" {
                            sentimentScore -= 1
                        }
                    }
                    
                    
                    if sentimentScore >= 0 {
                        self.sentimentLabel.text = "😃"
                    } else if sentimentScore == 0 {
                        self.sentimentLabel.text = "😒"
                    } else if sentimentScore < 0 {
                        self.sentimentLabel.text = "🤬"
                    }
                    
                } catch {
                    print("error clasifying tweets \(error)")
                }
                


            } failure: { (error) in
                print("Error fetching tweets \(error)")
            }
        }
    }
}

