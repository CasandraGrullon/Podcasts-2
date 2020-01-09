//
//  PodcastCell.swift
//  Podcasts
//
//  Created by Alex Paul on 12/17/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class PodcastCell: UITableViewCell {
  
  @IBOutlet weak var podcastImageView: UIImageView!
  @IBOutlet weak var collectionNameLabel: UILabel!
  @IBOutlet weak var artistNameLabel: UILabel!
  
  private var urlString = ""
  
  func configureCell(for podcast: Podcast) {
    
    collectionNameLabel.text = podcast.collectionName
    
    if let favoritedBy = podcast.favoritedBy {
      artistNameLabel.text = (podcast.artistName ?? "") + " - favoried by: \(favoritedBy)"
    } else {
      artistNameLabel.text = podcast.artistName
    }
    
    guard let imageURL = podcast.artworkUrl100 else {
      podcastImageView.image = UIImage(systemName: "mic.fill")
      return
    }
    
    urlString = imageURL
    
    podcastImageView.getImage(with: imageURL) { [weak self] result in
      switch result {
      case .failure:
        DispatchQueue.main.async {
          self?.podcastImageView.image = UIImage(systemName: "exclamationmark.triangle.fill")
        }
      case .success(let image):
        DispatchQueue.main.async {
          if self?.urlString == imageURL {
            self?.podcastImageView.image = image
          }
        }
      }
    }
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    podcastImageView.image = nil
  }
  
  
}
