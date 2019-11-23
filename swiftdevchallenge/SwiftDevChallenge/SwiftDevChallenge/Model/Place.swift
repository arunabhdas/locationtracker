//
//  Transaction.swift
//  SwiftDevChallenge
//
//  Created by Das on 11/22/19.
//  Copyright © 2019 Arunabh Das. All rights reserved.
//


struct Place {

    let title: String
    let description: String
    let address: String

    
    init(title: String, description: String, address: String ) {
        self.title = title
        self.description = description
        self.address = address
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case description = "description"
        case address = "address"
    
    }
}
