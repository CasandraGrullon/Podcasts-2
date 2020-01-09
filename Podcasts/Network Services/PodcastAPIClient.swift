//
//  PodcastAPIClient.swift
//  Podcasts
//
//  Created by Alex Paul on 12/17/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

struct PodcastAPIClient {
  
  static func searchPodcast(for name: String,
                            completion: @escaping (Result<[Podcast], AppError>) -> ()) {
    var urlComponenet = URLComponents(string: "https://itunes.apple.com/search")
    urlComponenet?.queryItems = [URLQueryItem(name: "media", value: "podcast"),
                                 URLQueryItem(name: "limit", value: "200"),
                                 URLQueryItem(name: "term", value: name)]
    
    guard let url = urlComponenet?.url else {
      completion(.failure(.badURL(urlComponenet?.url?.absoluteString ?? "")))
      return
    }
    var request = URLRequest(url: url)
    request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    NetworkHelper.shared.performDataTask(with: request) { (result) in
      switch result {
      case .failure(let appError):
        completion(.failure(.networkClientError(appError)))
      case .success(let data):
        do {
          let searchResults = try JSONDecoder().decode(PodcastSearch.self, from: data)
          completion(.success(searchResults.results))
        } catch {
          completion(.failure(.decodingError(error)))
        }
      }
    }
  }
  
  static func postToFavorites(favorite: Podcast,
                              completion: @escaping (Result<Bool, AppError>) -> ()) {
    let favoritesEndpointURLString = "https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites"
    
    guard let url = URL(string: favoritesEndpointURLString) else {
      completion(.failure(.badURL(favoritesEndpointURLString)))
      return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    do {
      let data = try JSONEncoder().encode(favorite)
      request.httpBody = data
      
      NetworkHelper.shared.performDataTask(with: request) { (result) in
        switch result {
        case .failure(let appError):
          completion(.failure(.networkClientError(appError)))
        case .success:
          completion(.success(true))
        }
      }
    } catch {
      completion(.failure(.encodingError(error)))
    }
  }
  
  static func fetchfavorites(completion: @escaping (Result<[Podcast], AppError>) -> ()) {
    let favoritesEndpointURLString = "https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites"
    guard let url = URL(string: favoritesEndpointURLString) else {
      completion(.failure(.badURL(favoritesEndpointURLString)))
      return
    }
    let request = URLRequest(url: url)
    NetworkHelper.shared.performDataTask(with: request) { (result) in
      switch result {
      case .failure(let appError):
        completion(.failure(.networkClientError(appError)))
      case .success(let data):
        do {
          let podcasts = try JSONDecoder().decode([Podcast].self, from: data)
          completion(.success(podcasts))
        } catch {
          completion(.failure(.decodingError(error)))
        }
      }
    }
  }
}
