//
//  Definition.swift
//  FlashcardAutomater
//
//  Created by Leon on 2023/7/17.
//

import Foundation

struct Definition: Decodable {
    var definition: String
    var example: String?
    var synonyms: [String]
    var antonyms: [String]
}
