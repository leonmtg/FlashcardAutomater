//
//  Meaning.swift
//  FlashcardAutomater
//
//  Created by Leon on 2023/7/17.
//

import Foundation

struct Meaning: Decodable {
    var partOfSpeech: String
    var definitions: [Definition]
    var synonyms: [String]
    var antonyms: [String]
}
