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
        if synonyms.count > 0 {
            text.append("<br /> SYNONYMS ")
            text.append(synonyms.map { "**\($0)**" }.joined(separator: ", "))
        }
        if antonyms.count > 0 {
            text.append("<br /> ANTONYMS ")
            text.append(antonyms.map { "**\($0)**" }.joined(separator: ", "))
        }
        if let example {
            text.append("<br />• <span style=\"color: rgb(0, 85, 127);\">*\(example)*</span>")
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
