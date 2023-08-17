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

extension Meaning: MarkdownSupported {
    var markdownText: String {
        var text = "***\(partOfSpeech)***"
        let hasIndex = definitions.count > 1
        let definitionTexts = definitions.enumerated()
            .map { index, definition in
                if hasIndex {
                    return "**\(index + 1)** \(definition.markdownText)"
                } else {
                    return definition.markdownText
                }
            }
            .joined(separator: "<br />")
        
        text.append("\n<br />\(definitionTexts)")
        
        if synonyms.count > 0 {
            text.append("<br /> SYNONYMS ")
            text.append(synonyms.map { "**\($0)**" }.joined(separator: ", "))
        }
        if antonyms.count > 0 {
            text.append("<br /> ANTONYMS ")
            text.append(antonyms.map { "**\($0)**" }.joined(separator: ", "))
        }
        
        return text
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
