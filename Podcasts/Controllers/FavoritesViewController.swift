//
//  FavoritesViewController.swift
//  Podcasts
//
//  Created by Alex Paul on 12/17/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  private var refreshControl: UIRefreshControl!
  
  private var podcasts = [Podcast]() {
    didSet {
      DispatchQueue.main.async {
        self.navigationItem.title = "Favorites (\(self.podcasts.count))"
        self.tableView.reloadData()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    
    // register Podcast nib here
    tableView.register(UINib(nibName: "PodcastCell", bundle: nil), forCellReuseIdentifier: "podcastCell")
    
    configureRefreshControl()
    fetchFavorites()
  }
  
  private func configureRefreshControl() {
    refreshControl = UIRefreshControl()
    tableView.refreshControl = refreshControl
    refreshControl.addTarget(self, action: #selector(fetchFavorites), for: .valueChanged)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let podcastDetailController = segue.destination as? PodcastDetailController,
      let indexPath = tableView.indexPathForSelectedRow else {
        fatalError("could not downcast to PodcastDetailController")
    }
    let podcast = podcasts[indexPath.row]
    podcastDetailController.podcast = podcast
  }
  
  @objc
  private func fetchFavorites() {
    PodcastAPIClient.fetchfavorites { [weak self] (result) in
      DispatchQueue.main.async {
        self?.refreshControl.endRefreshing()
      }
      switch result {
      case .failure(let appError):
        print(appError)
      case .success(let podcasts):
        //fatalError("update the filter name below then remove this fatalError() line")
        self?.podcasts = podcasts.filter { $0.favoritedBy == "Casandra" }
      }
    }
  }
}

extension FavoritesViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return podcasts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "podcastCell", for: indexPath) as? PodcastCell else {
      fatalError("could not downcast a PodcastCell")
    }
    let podcast = podcasts[indexPath.row]
    cell.configureCell(for: podcast)
    return cell
  }
}

extension FavoritesViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 180
  }
  
  // TODO: implemnet didSelectRowAt to pass podcast data to the detail view
  //       we need to add an identifier to the PodcastDetailController scene in the Main storyboard in order to get an instance of it
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = storyboard?.instantiateViewController(identifier: "PodcastDetailController") as? PodcastDetailController else {
            fatalError("could not downcast as PodcastDetailController")
        }
        
        let podcast = podcasts[indexPath.row]
        detailVC.podcast = podcast
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
