//
//  Transaction.swift
//  SwiftDevChallenge
//
//  Created by Das on 11/22/19.
//  Copyright © 2019 Arunabh Das. All rights reserved.
//

import Foundation

// MARK: - Prediction

struct Prediction: Codable {
    let predictionDescription, id: String
    let matchedSubstrings: [MatchedSubstring]
    let placeID, reference: String
    let structuredFormatting: StructuredFormatting
    let terms: [Term]
    let types: [TypeElement]

    enum CodingKeys: String, CodingKey {
        case predictionDescription = "description"
        case id
        case matchedSubstrings = "matched_substrings"
        case placeID = "place_id"
        case reference
        case structuredFormatting = "structured_formatting"
        case terms, types
    }

}
