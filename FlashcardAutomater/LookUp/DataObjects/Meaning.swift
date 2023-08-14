//
//  Meaning.swift
//  FlashcardAutomater
//
//  Created by Leon on 2023/7/17.
//

import Foundation

struct Meaning: Decodable, Identifiable {
    var id = UUID()
    
    var partOfSpeech: String
    var definitions: [Definition]
    var synonyms: [String]
    var antonyms: [String]
    
    private enum CodingKeys: String, CodingKey {
        case partOfSpeech, definitions, synonyms, antonyms
    }
}

extension Meaning {
    static let mock: Meaning = {
        let json = """
      {
        "partOfSpeech": "noun",
        "definitions": [
          {
            "definition": "\\"Hello!\\" or an equivalent greeting.",
            "synonyms": [],
            "antonyms": []
          }
        ],
        "synonyms": [
          "greeting"
        ],
        "antonyms": []
      }
"""
        let jsonData = json.data(using: .utf8)!
        return try! JSONDecoder().decode(Meaning.self, from: jsonData)
    }()
}
