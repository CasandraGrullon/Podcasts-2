//
//  PodcastViewController.swift
//  Podcasts
//
//  Created by Alex Paul on 12/17/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class PodcastDetailController: UIViewController {
  
  @IBOutlet weak var podcastImageView: UIImageView!
  @IBOutlet weak var artistNameLabel: UILabel!
  @IBOutlet weak var collectionNameLabel: UILabel!
  
  var podcast: Podcast?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateUI()
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    podcastImageView.layer.cornerRadius = 8
  }
  
  private func updateUI() {
    guard let podcast = podcast else {
      fatalError("could not access podcast, verify it was passed in prepare(for segue:)")
    }
    artistNameLabel.text = podcast.artistName
    collectionNameLabel.text = podcast.collectionName
    podcastImageView.getImage(with: podcast.artworkUrl600) { [weak self] (result) in
      switch result {
      case .failure:
        DispatchQueue.main.async {
          self?.podcastImageView.image = UIImage(systemName: "mic.fill")
        }
      case .success(let image):
        DispatchQueue.main.async {
          self?.podcastImageView.image = image
        }
      }
    }
  }
  
  @IBAction func favoritePodcast(_ sender: UIBarButtonItem) {
    sender.isEnabled = false
    guard let podcast = podcast else {
      sender.isEnabled = true
      fatalError("could not retrieve podcast")
    }
    
    let favoritePodcast = Podcast(artworkUrl600: podcast.artworkUrl600,
                                  collectionName: podcast.collectionName,
                                  artworkUrl100: podcast.artworkUrl100,
                                  artistName: podcast.artistName,
                                  favoritedBy: "Casandra")
    //fatalError("Please update your name in the favoritedBy argument above then remove this line.")
    
    PodcastAPIClient.postToFavorites(favorite: favoritePodcast) { [weak self, weak sender] (result) in
      switch result {
      case .failure(let appError):
        DispatchQueue.main.async {
          sender?.isEnabled = true
          self?.showAlert(title: "Failed to post", message: "\(appError)")
        }
      case .success:
        DispatchQueue.main.async {
          sender?.isEnabled = true
          self?.showAlert(title: "Posted", message: "\(podcast.collectionName) was favorited.") { alert in
            self?.dismiss(animated: true)
            self?.tabBarController?.selectedIndex = 1

          }
        }
      }
    }
    
  }
  
}
