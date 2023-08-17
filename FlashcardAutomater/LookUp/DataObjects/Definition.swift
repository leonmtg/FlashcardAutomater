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

extension Definition: MarkdownSupported {
    var markdownText: String {
        var text = definition
        if let example {
            text.append("<br />• \(example)")
        }
        return text
    }
}

extension Definition {
    static let mock: Definition = {
        let json = """
{
            "definition": "A call for response if it is not clear if anyone is present or listening, or if a telephone conversation may have been disconnected.",
            "synonyms": [],
            "antonyms": [],
            "example": "Hello? Is anyone there?"
          }
"""
        let jsonData = json.data(using: .utf8)!
        return try! JSONDecoder().decode(Definition.self, from: jsonData)
    }()
}
