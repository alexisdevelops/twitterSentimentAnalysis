//
//  Secrets.swift
//  Twittermenti
//
//  Created by alexis on 04/01/21.
//  Copyright © 2021 London App Brewery. All rights reserved.
//

import Foundation

class SecretParser {
    
    struct Secrets: Decodable {
        private enum CodingKeys: String, CodingKey {
            case APISecret, APIKey
        }

        let APISecret: String
        let APIKey: String
    }
    
    func parseSecrets() -> Secrets {
        let url = Bundle.main.url(forResource: "Secrets", withExtension: "plist")!
        let data = try! Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        return try! decoder.decode(Secrets.self, from: data)
    }
}



