This is based on the [FeedKit](https://github.com/nmdias/FeedKit), but adds newest Swift `async` `await` support, so it can be used easily in SwiftUI apps.
Also, I removed Cocoapods, since it is 21st century and I think Swift Package makes it much easier.

## Features

- [x] [Atom](https://tools.ietf.org/html/rfc4287)
- [x] RSS [0.90](http://www.rssboard.org/rss-0-9-0), [0.91](http://www.rssboard.org/rss-0-9-1), [1.00](http://web.resource.org/rss/1.0/spec), [2.00](http://cyber.law.harvard.edu/rss/rss.html)
- [x] [JSON](https://jsonfeed.org/version/1)
- [x] Swift async/await support

## Usage

Build a URL pointing to an RSS, Atom or JSON Feed.
```swift
let feedURL = URL(string: "http://images.apple.com/main/rss/hotnews/hotnews.rss")!
```

Get an instance of `FeedParser`
```swift
let parser = FeedParser(URL: feedURL) // or FeedParser(data: data) or FeedParser(xmlStream: stream)
```

Then call `parse`  to start parsing the feed...

```swift
let parser = FeedParser(URL: userEntryURL)
let result = try await parser.parse()
self.fetchedFeedData = result
switch result {
    case .atom(let atomFeed):
        self.fetchedSiteTitle = atomFeed.title
        self.fetchedSiteSubtitle = atomFeed.subtitle?.value
        self.latestCuratedDate = atomFeed.updated
        if let icon = atomFeed.icon,
           let iconURL = URL(string: icon),
           let (iconData, _) = try? await URLSession.shared.data(from: iconURL),
           let iconImage = UIImage(data: iconData) {
            self.fetchedSiteImage = iconImage
        }
    case .rss(let rssFeed):
        self.fetchedSiteTitle = rssFeed.title
        self.fetchedSiteSubtitle = rssFeed.description
        self.latestCuratedDate = rssFeed.lastBuildDate
    case .json(let jsonFeed):
        self.fetchedSiteTitle = jsonFeed.title
        self.fetchedSiteSubtitle = jsonFeed.description
}
```     

## Parse Result

FeedKit adopts Swift 5 Result type, as `Result<Feed, ParserError>`, and as such, if parsing succeeds you should now have a `Strongly Typed Model` of an `RSS`, `Atom` or `JSON Feed`, within the `Feed` enum:

```swift
switch result {
case .success(let feed):
    
    // Grab the parsed feed directly as an optional rss, atom or json feed object
    feed.rssFeed
    
    // Or alternatively...
    switch feed {
    case let .atom(feed):       // Atom Syndication Format Feed Model
    case let .rss(feed):        // Really Simple Syndication Feed Model
    case let .json(feed):       // JSON Feed Model
    }
    
case .failure(let error):
    print(error)
}
```

## Model Preview

> The RSS and Atom feed Models are rather extensive throughout the supported namespaces. These are just a preview of what's available.

#### RSS

```swift
feed.title
feed.link
feed.description
feed.language
feed.copyright
feed.managingEditor
feed.webMaster
feed.pubDate
feed.lastBuildDate
feed.categories
feed.generator
feed.docs
feed.cloud
feed.rating
feed.ttl
feed.image
feed.textInput
feed.skipHours
feed.skipDays
//...
feed.dublinCore
feed.syndication
feed.iTunes
// ...

let item = feed.items?.first

item?.title
item?.link
item?.description
item?.author
item?.categories
item?.comments
item?.enclosure
item?.guid
item?.pubDate
item?.source
//...
item?.dublinCore
item?.content
item?.iTunes
item?.media
// ...
```

#### Atom

```swift
feed.title
feed.subtitle
feed.links
feed.updated
feed.authors
feed.contributors
feed.id
feed.generator
feed.icon
feed.logo
feed.rights
// ...

let entry = feed.entries?.first

entry?.title
entry?.summary
entry?.authors
entry?.contributors
entry?.links
entry?.updated
entry?.categories
entry?.id
entry?.content
entry?.published
entry?.source
entry?.rights
// ...
```

#### JSON

```swift
feed.version
feed.title
feed.homePageURL
feed.feedUrl
feed.description
feed.userComment
feed.nextUrl
feed.icon
feed.favicon
feed.author
feed.expired
feed.hubs
feed.extensions
// ...

let item = feed.items?.first

item?.id
item?.url
item?.externalUrl
item?.title
item?.contentText
item?.contentHtml
item?.summary
item?.image
item?.bannerImage
item?.datePublished
item?.dateModified
item?.author
item?.url
item?.tags
item?.attachments
item?.extensions
// ...
```

## License

Released under the MIT license. See LICENSE file for details.



