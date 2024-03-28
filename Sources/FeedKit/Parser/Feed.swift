//
//  Feed.swift
//
//  Copyright (c) 2016 - 2018 Nuno Manuel Dias
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation

public enum Feed: Equatable {
    case atom(AtomFeed)
    case rss(RSSFeed)
    case json(JSONFeed)
}

// MARK: - Convenience properties

extension Feed {
    
    public var title: String? {
        switch self {
            case .atom(let atomFeed):
                return atomFeed.title
            case .rss(let rSSFeed):
                return rSSFeed.title
            case .json(let jSONFeed):
                return jSONFeed.title
        }
    }
    
    public var itemCount: Int {
        switch self {
            case .atom(let atomFeed):
                return atomFeed.entries?.count ?? 0
            case .rss(let rSSFeed):
                return rSSFeed.items?.count ?? 0
            case .json(let jSONFeed):
                return jSONFeed.items?.count ?? 0
        }
    }
    
    public var aiSummarizableContent: String {
        var contents: [String] = []
        switch self {
            case .atom(let atomFeed):
                for item in (atomFeed.entries ?? []).prefix(15) {
                    guard let postSummaryText = item.summary?.value ?? item.title else { continue }
                    contents.append("- \(postSummaryText.prefix(30))")
                }
            case .rss(let rSSFeed):
                for item in (rSSFeed.items ?? []).prefix(15) {
                    guard let postSummaryText = item.description ?? item.title else { continue }
                    contents.append("- \(postSummaryText.prefix(30))")
                }
            case .json(let jSONFeed):
                for item in (jSONFeed.items ?? []).prefix(15) {
                    guard let postSummaryText = item.summary ?? item.title else { continue }
                    contents.append("- \(postSummaryText.prefix(30))")
                }
        }
        return contents.joined(separator: "\n\n")
    }
    
    public var rssFeed: RSSFeed? {
        guard case let .rss(feed) = self else { return nil }
        return feed
    }

    public var atomFeed: AtomFeed? {
        guard case let .atom(feed) = self else { return nil }
        return feed
    }

    public var jsonFeed: JSONFeed? {
        guard case let .json(feed) = self else { return nil }
        return feed
    }

}
