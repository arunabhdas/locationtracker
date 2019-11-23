//
//  PlacesResponse.swift
//  SwiftDevChallenge
//
//  Created by Das on 11/23/19.
//  Copyright © 2019 Arunabh Das. All rights reserved.
//

import Foundation

// MARK: - PlacesResponse
struct PlacesResponse: Codable {
    let predictions: [Prediction]
    let status: String
}
