//
//  PodcastsTests.swift
//  PodcastsTests
//
//  Created by Alex Paul on 12/17/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import XCTest
@testable import Podcasts

class PodcastsTests: XCTestCase {

  func testPodcastModel() {
    let jsonData = """
          {
          "resultCount": 123,
          "results": [
              {
                  "wrapperType": "track",
                  "kind": "podcast",
                  "collectionId": 477534265,
                  "trackId": 477534265,
                  "artistName": "TaylorTalk.org - The Taylor Swift Podcast by: Adam Bromberg, Diane, Steve",
                  "collectionName": "Taylor Talk: The Taylor Swift Podcast | reputation | 1989 | Red | Speak Now | Fearless | Taylor Swift",
                  "trackName": "Taylor Talk: The Taylor Swift Podcast | reputation | 1989 | Red | Speak Now | Fearless | Taylor Swift",
                  "collectionCensoredName": "Taylor Talk: The Taylor Swift Podcast | reputation | 1989 | Red | Speak Now | Fearless | Taylor Swift",
                  "trackCensoredName": "Taylor Talk: The Taylor Swift Podcast | reputation | 1989 | Red | Speak Now | Fearless | Taylor Swift",
                  "collectionViewUrl": "https://podcasts.apple.com/us/podcast/taylor-talk-taylor-swift-podcast-reputation-1989-red/id477534265?uo=4",
                  "feedUrl": "http://taylortalk.libsyn.com/rss",
                  "trackViewUrl": "https://podcasts.apple.com/us/podcast/taylor-talk-taylor-swift-podcast-reputation-1989-red/id477534265?uo=4",
                  "artworkUrl30": "https://is5-ssl.mzstatic.com/image/thumb/Podcasts123/v4/04/c0/81/04c0814e-a769-f4f4-1c22-ca6858766712/mza_7428247299061024805.jpg/30x30bb.jpg",
                  "artworkUrl60": "https://is5-ssl.mzstatic.com/image/thumb/Podcasts123/v4/04/c0/81/04c0814e-a769-f4f4-1c22-ca6858766712/mza_7428247299061024805.jpg/60x60bb.jpg",
                  "artworkUrl100": "https://is5-ssl.mzstatic.com/image/thumb/Podcasts123/v4/04/c0/81/04c0814e-a769-f4f4-1c22-ca6858766712/mza_7428247299061024805.jpg/100x100bb.jpg",
                  "collectionPrice": 0.00,
                  "trackPrice": 0.00,
                  "trackRentalPrice": 0,
                  "collectionHdPrice": 0,
                  "trackHdPrice": 0,
                  "trackHdRentalPrice": 0,
                  "releaseDate": "2018-02-20T05:01:00Z",
                  "collectionExplicitness": "cleaned",
                  "trackExplicitness": "cleaned",
                  "trackCount": 100,
                  "country": "USA",
                  "currency": "USD",
                  "primaryGenreName": "Music",
                  "contentAdvisoryRating": "Clean",
                  "artworkUrl600": "https://is5-ssl.mzstatic.com/image/thumb/Podcasts123/v4/04/c0/81/04c0814e-a769-f4f4-1c22-ca6858766712/mza_7428247299061024805.jpg/600x600bb.jpg",
                  "genreIds": [
                      "1310",
                      "26",
                      "1305"
                  ],
                  "genres": [
                      "Music",
                      "Podcasts",
                      "Kids & Family"
                  ]
              },
              {
                  "wrapperType": "track",
                  "kind": "podcast",
                  "artistId": 1280771285,
                  "collectionId": 1315130780,
                  "trackId": 1315130780,
                  "artistName": "Paul Hegarty",
                  "collectionName": "Developing iOS 11 Apps with Swift",
                  "trackName": "Developing iOS 11 Apps with Swift",
                  "collectionCensoredName": "Developing iOS 11 Apps with Swift",
                  "trackCensoredName": "Developing iOS 11 Apps with Swift",
                  "artistViewUrl": "https://podcasts.apple.com/us/artist/stanford/1280771285?uo=4",
                  "collectionViewUrl": "https://podcasts.apple.com/us/podcast/developing-ios-11-apps-with-swift/id1315130780?uo=4",
                  "feedUrl": "https://applehosted.podcasts.apple.com/stanford/developing_ios11_apps.xml",
                  "trackViewUrl": "https://podcasts.apple.com/us/podcast/developing-ios-11-apps-with-swift/id1315130780?uo=4",
                  "artworkUrl30": "https://is2-ssl.mzstatic.com/image/thumb/Podcasts113/v4/a8/c0/09/a8c0099a-3e9a-3a6b-f4af-b2767e25630d/mza_6721617997679729951.png/30x30bb.jpg",
                  "artworkUrl60": "https://is2-ssl.mzstatic.com/image/thumb/Podcasts113/v4/a8/c0/09/a8c0099a-3e9a-3a6b-f4af-b2767e25630d/mza_6721617997679729951.png/60x60bb.jpg",
                  "artworkUrl100": "https://is2-ssl.mzstatic.com/image/thumb/Podcasts113/v4/a8/c0/09/a8c0099a-3e9a-3a6b-f4af-b2767e25630d/mza_6721617997679729951.png/100x100bb.jpg",
                  "collectionPrice": 0.00,
                  "trackPrice": 0.00,
                  "trackRentalPrice": 0,
                  "collectionHdPrice": 0,
                  "trackHdPrice": 0,
                  "trackHdRentalPrice": 0,
                  "releaseDate": "2017-11-13T10:46:00Z",
                  "collectionExplicitness": "cleaned",
                  "trackExplicitness": "cleaned",
                  "trackCount": 46,
                  "country": "USA",
                  "currency": "USD",
                  "primaryGenreName": "Education",
                  "contentAdvisoryRating": "Clean",
                  "artworkUrl600": "https://is2-ssl.mzstatic.com/image/thumb/Podcasts113/v4/a8/c0/09/a8c0099a-3e9a-3a6b-f4af-b2767e25630d/mza_6721617997679729951.png/600x600bb.jpg",
                  "genreIds": [
                      "1304",
                      "26"
                  ],
                  "genres": [
                      "Education",
                      "Podcasts"
                  ]
              }
            ]
        }
    """.data(using: .utf8)!
    
    let expectedPodcastCount = 2
    
    // act
    let searchResults = try! JSONDecoder().decode(PodcastSearch.self, from: jsonData)
    let podcasts = searchResults.results
    
    // assert
    XCTAssertEqual(podcasts.count, expectedPodcastCount)
  }

}
