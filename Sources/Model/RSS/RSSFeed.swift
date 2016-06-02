//
//  RSSFeed.swift
//
//  Copyright (c) 2016 Nuno Manuel Dias
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

/**
 
 Data model for the XML DOM of the RSS 2.0 Specification
 See http://cyber.law.harvard.edu/rss/rss.html
 
 At the top level, a RSS document is a <rss> element, with a mandatory 
 attribute called version, that specifies the version of RSS that the 
 document conforms to. If it conforms to this specification, the version 
 attribute must be 2.0.
 
 Subordinate to the <rss> element is a single <channel> element, which 
 contains information about the channel (metadata) and its contents.
 
*/
public class RSSFeed {
    
    /**
     
     Subordinate to the <rss> element. Contains information about the channel
     (metadata) and its contents.
     
     */
    public var channel: RSSFeedChannel?
    
    public init() {}
    
}