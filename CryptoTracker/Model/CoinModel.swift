//
//  CoinModel.swift
//  CryptoTracker
//
//  Created by Chris Cosentino on 2018-07-11.
//  Copyright © 2018 Chris Cosentino. All rights reserved.
//

import Foundation


struct Bitcoin: Codable{
    let data: [String: CoinInfo]
    
    struct CoinInfo: Codable{
        let id: Int
        let name: String
        let symbol: String
        let quotes: Quotes
        
        
        struct Quotes: Codable{
            
            let USD: CoinPrices
            
            struct CoinPrices: Codable{
                let price: Double
                let percent_change_1h: Double
                let percent_change_24h: Double
                let percent_change_7d: Double
            }
        }
    }
}

