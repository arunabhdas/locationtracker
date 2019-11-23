//
//  StructuredFormatting.swift
//  SwiftDevChallenge
//
//  Created by Das on 11/23/19.
//  Copyright © 2019 Arunabh Das. All rights reserved.
//

import Foundation

// MARK: - StructuredFormatting
struct StructuredFormatting: Codable {
    let mainText: String
    let mainTextMatchedSubstrings: [MatchedSubstring]
    let secondaryText: String

    enum CodingKeys: String, CodingKey {
        case mainText = "main_text"
        case mainTextMatchedSubstrings = "main_text_matched_substrings"
        case secondaryText = "secondary_text"
    }
}
