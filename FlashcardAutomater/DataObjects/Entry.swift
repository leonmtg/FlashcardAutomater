//
//  Entry.swift
//  FlashcardAutomater
//
//  Created by Leon on 2023/7/17.
//

import Foundation

struct Entry: Decodable {
    var word: String
    var phonetic: Phonetic?
    var phonetics: [Phonetic]
    var meanings: [Meaning]
    var origin: String?
}
