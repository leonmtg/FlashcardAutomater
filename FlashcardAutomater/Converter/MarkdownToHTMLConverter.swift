//
//  MarkdownToHTMLConverter.swift
//  FlashcardAutomater
//
//  Created by Leon on 2023/8/17.
//

import MarkdownKit

struct MarkdownToHTMLConverter {
    static func convertMarkdownSupported(_ from: some MarkdownSupported) -> String {
        let formattedText = from.markdownText
        let markdown = MarkdownParser.standard.parse(formattedText)
        return HtmlGenerator.standard.generate(doc: markdown)
    }
    
    static func convertMarkdownSupportedArray(_ from: [some MarkdownSupported], separator: String) -> String {
        let formattedText = from.map { $0.markdownText }.joined(separator: separator)
        let markdown = MarkdownParser.standard.parse(formattedText)
        return HtmlGenerator.standard.generate(doc: markdown)
    }
}
