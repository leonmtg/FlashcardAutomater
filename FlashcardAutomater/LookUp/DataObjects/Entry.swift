//
//  Entry.swift
//  FlashcardAutomater
//
//  Created by Leon on 2023/7/17.
//

import Foundation

struct Entry: Decodable, Identifiable {
    var id = UUID()
    
    var word: String
    var phonetic: String?
    var phonetics: [Phonetic]
    var meanings: [Meaning]
    var origin: String?
    
    private enum CodingKeys: String, CodingKey {
        case word, phonetic, phonetics, meanings, origin
    }
}

extension Entry: MarkdownSupported {
    var markdownText: String {
        let meaningTexts = meanings.map { $0.markdownText }.joined(separator: "<br />")
        return "# \(word) \n\(meaningTexts)"
    }
}

extension Entry {
    static let mock: Entry = {
        let json = """
{
    "word": "persuade",
    "phonetic": "/pəˈsweɪd/",
    "phonetics": [
      {
        "text": "/pəˈsweɪd/",
        "audio": ""
      },
      {
        "text": "/pɚˈsweɪd/",
        "audio": "https://api.dictionaryapi.dev/media/pronunciations/en/persuade-us.mp3",
        "sourceUrl": "https://commons.wikimedia.org/w/index.php?curid=2423299",
        "license": {
          "name": "BY-SA 3.0",
          "url": "https://creativecommons.org/licenses/by-sa/3.0"
        }
      }
    ],
    "meanings": [
      {
        "partOfSpeech": "verb",
        "definitions": [
          {
            "definition": "To successfully convince (someone) to agree to, accept, or do something, usually through reasoning and verbal influence.",
            "synonyms": [],
            "antonyms": [
              "deter",
              "dissuade"
            ],
            "example": "That salesman was able to persuade me into buying this bottle of lotion."
          },
          {
            "definition": "To convince of by argument, or by reasons offered or suggested from reflection, etc.; to cause to believe (something).",
            "synonyms": [],
            "antonyms": []
          },
          {
            "definition": "To urge, plead; to try to convince (someone to do something).",
            "synonyms": [],
            "antonyms": []
          }
        ],
        "synonyms": [
          "convince"
        ],
        "antonyms": [
          "deter",
          "dissuade"
        ]
      }
    ],
    "license": {
      "name": "CC BY-SA 3.0",
      "url": "https://creativecommons.org/licenses/by-sa/3.0"
    },
    "sourceUrls": [
      "https://en.wiktionary.org/wiki/persuade"
    ]
  }
"""
        let jsonData = json.data(using: .utf8)!
        return try! JSONDecoder().decode(Entry.self, from: jsonData)
    }()
}
