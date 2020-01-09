//
//  Podcast.swift
//  Podcasts
//
//  Created by Alex Paul on 12/17/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

struct PodcastSearch: Codable {
  let results: [Podcast]
}
struct Podcast: Codable {
  let artworkUrl600: String
  let collectionName: String
  let artworkUrl100: String?
  let artistName: String?
  let favoritedBy: String?
}
